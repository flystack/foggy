require 'misty/restful/method_builder'
require 'misty/restful/http/request'
require 'misty/restful/http/direct'

module Misty
  module RESTful
    class Client
      class InvalidDataError < StandardError; end

      include Misty::RESTful::MethodBuilder
      include Misty::RESTful::HTTP::Request
      include Misty::RESTful::HTTP::Direct

      INTERFACES = %w{admin public internal}

      attr_reader :microversion

      Options = Struct.new(:base_path, :base_url, :interface, :region_id, :service_names, :ssl_verify_mode, :version)

      def requests
        list = []
        self.class.api.each do |_path, verbs|
          verbs.each do |_verb, requests|
            list << requests
          end
        end
        list.flatten.sort
      end

      # Options - Values shown are the default
      #   Base path can be forced (Not recommended, mainly used for test purposes)
      #    :base_path => nil
      #   URL can be forced (Helps when setup is broken)
      #    :base_url => nil
      #   Endpoint type (admin, public or internal)
      #     :interface => "public"
      #   Region ID
      #    :region_id => "regionOne"
      #   Service name
      #    The Service names are pre defined but more can be added using this option.
      #    :service_name
      #   SSL Verify Mode
      #     :ssl_verify_mode => true
      #   (micro)version: Can be numbered (3.1) or by state (CURRENT, LATEST or SUPPORTED)
      #     :version => "CURRENT"
      def initialize(cloud, options)
        @cloud = cloud
        @options = setup(options)
        @uri = URI.parse(@cloud.auth.get_endpoint(@options.service_names, @options.region_id, @options.interface))
        @base_path = @options.base_path ? @options.base_path : @uri.path
        @base_path = @base_path.chomp("/")
        @http = net_http(@uri)
        @version = nil
        @microversion = false
      end

      # Sub classes to override
      # When a catalog provides a base path and the Service API definition containts the generic equivalent as prefix
      # then the preifx is redundant and must be removed from the path.
      # For example:
      # Catalog provides "http://192.0.2.21:8004/v1/48985e6b8da145699d411f12a3459fca"
      # and Service API has "/v1/{tenant_id}/stacks"
      # then the path prefix is ignored and path is only "/stacks"
      def self.prefix_path_to_ignore
        ""
      end

      def headers_default
        Misty::HEADER_JSON
      end

      def headers
        h = headers_default.merge("X-Auth-Token" => "#{@cloud.auth.get_token}")
        h.merge!(microversion_header) if microversion
        h
      end

      # TODO: unit
      def self.define_collection(name)
        collection_klass = "Misty::Collection::#{self.baseclass.capitalize}::#{name.capitalize}"
        unless Misty.class_exist?(collection_klass)
          Misty.create_class(collection_klass, Misty::Collection::Base)
        end

        unless Misty.class_exist?(collection_klass.chop)
          Misty.create_class(collection_klass.chop, Misty::Collection::Element)
        end

        # Equivalent of
        # def subnets
        #   @subnets ||= Misty::Collection::Network::Subnets.new(self)
        # end
        define_method("#{name}") do
          if instance_variable_defined?("@#{name}")
            instance_variable_get("@#{name}")
          else
            instance_variable_set("@#{name}", Object.const_get(collection_klass).send(:new, self))
          end
        end
      end

      private

      def self.baseclass
        self.to_s.split('::')[-1]
      end

      # TODO: Replace call with class method
      def baseclass
        self.class.to_s.split('::')[-1]
      end

      def net_http(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.set_debug_output($stdout) if @cloud.log.level == Logger::DEBUG
        if uri.scheme == "https"
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE unless @options[:ssl_verify_mode]
        end
        http
      end

      def setup(params)
        options = Options.new()
        options.base_path       = params[:base_path]       ? params[:base_path] : nil
        options.base_url        = params[:base_url]        ? params[:base_url] : nil
        options.interface       = params[:interface]       ? params[:interface] : "public"
        options.region_id       = params[:region_id]       ? params[:region_id] : "regionOne"
        options.service_names   = params[:service_name]    ? self.class.service_names << params[:service_name] : self.class.service_names
        options.ssl_verify_mode = params[:ssl_verify_mode] ? params[:ssl_verify_mode] : true
        options.version         = params[:version]         ? params[:version] : "CURRENT"

        unless INTERFACES.include?(options.interface)
          raise InvalidDataError, "Options ':interface'must be one of #{INTERFACES}"
        end

        unless options.ssl_verify_mode == !!options.ssl_verify_mode
          raise InvalidDataError, "Options ':ssl_verify_mode' must be a boolean"
        end
        options
      end
    end
  end
end
