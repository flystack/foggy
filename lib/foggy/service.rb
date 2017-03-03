module Foggy
  class Service
    # By default when a single_name is not provided then the singular name is deducted from the plural_name:
    # - When a name ends with 'ies' it will be replaced with 'y'
    # - Otherwise the last letter is removed
    # In any other case the single name should be provided
    def self.define(plural_name, single_name = nil)
      single_name ||= singular(plural_name, single_name)
      create_collection_class(plural_name.to_s.capitalize, single_name.capitalize)

      # def subnets
      #   @subnets ||= Foggy::Networking::Subnets.new(self)
      # end
      klass = self.const_get(plural_name.capitalize)
      define_method("#{plural_name}") do
        unless instance_variable_defined?("@#{plural_name}")
          instance_variable_set("@#{plural_name}", klass.new(@service, single_name))
        end
        return instance_variable_get("@#{plural_name}")
      end
    end

    def self.class_exists?(name)
      return true if !!self.const_get(name)
    rescue
      false
    end

    # module Foggy::Networking example:
    # class Subnets
    #   include Foggy::Collection
    #
    #   class Subnet
    #     include Foggy::Element
    #   end
    # end
    def self.create_collection_class(name, single_name)
      unless class_exists?(name)
        self.const_set(name, Class.new do
          include Foggy::Collection

          self.const_set(single_name, Class.new do
            include Foggy::Element
          end)
        end)
      else
        raise RuntimeError, "Error: #{self}::#{name} already defined"
      end
    end

    def self.singular(plural_name, single_name)
      unless single_name
        if name =~ /ies$/
          # policies => policy
          plural_name.to_s.sub(/ies$/, 'y')
        else
          # somethings => something
          plural_name.to_s.chop
        end
      else
        single_name
      end
    end

    def initialize(service)
      @service = service
    end

    def request(*args)
      @service.send(*args)
    end
  end
end
