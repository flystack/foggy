module Foggy
  module Collection
    class Base
      def initialize(service)
        @service = service
        @list = build
      end

      def collection_prefix
        self.class.to_s.split('::')[-1].downcase
      end

      def collection_name
        self.class.to_s.split('::')[-1].downcase
      end

      def fetch_all_name
        "list_#{collection_name}"
      end

      def fetch_element_name
        "show_#{single_name}_details"
      end

      def service_class
        @service.class.to_s.split('::')[-1]
      end

      def single_name
        collection_name.chop
      end

      def collection
        @collection ||= fetch_all
      end

      def fetch_all
        response = @service.send(fetch_all_name)
        response.body[collection_name] if response.code =~ /200/
      end

      def fetch(id)
        response = @service.send(fetch_element_name, id)
        response.body[single_name] if response.code =~ /200/
      end

      def element_klass
        # For instance: Foggy::Collection::Network::Subnet
        klass_name = "Foggy::Collection::#{service_class}::#{single_name.capitalize}"
        Object.const_get(klass_name)
      end

      def build
        list = []
        if collection
          collection.each do |element|
            list << element_klass.send(:new, element)
          end
        end
        list
      end

      def all
        @list
      end

      def get(id)
        element = fetch(id)
        if element
          element_klass.send(:new, element)
        end
      end

      def reload
        @collection = fetch_all
      end
    end
  end
end
