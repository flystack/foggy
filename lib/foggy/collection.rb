module Foggy
  module Collection
    def initialize(element)
      @element_klass = self.class.const_get(element.capitalize)
      @collection_kass = self.class
      @collection = collect
    end

    def all
      @collection
    end

    def create(element)
      api_create_element = "create_#{element_name}".to_sym
      response = service.send(api_create_element, element)
    end

    def get(id)
      element = fetch(id)
      @element_klass.new(element) if element
    end

    def element_name
      klass_name(@element_klass).downcase
    end

    def reload
      @collection = fetch_all
    end

    private

    def collect
      list = []
      if collection
        collection.each do |element|
          list << @element_klass.new(element)
        end
      end
      list
    end

    def collection
      @collection ||= fetch_all
    end

    def collection_name
      klass_name(self.class).downcase
    end

    def fetch(id)
      api_show_element_details = "show_#{element_name}_details"
      response = service.send(api_show_element_details, id)
      response.body[element_name] if response.code =~ /200/
    end

    def fetch_all
      api_list_collection = "list_#{collection_name}"
      response = service.send(api_list_collection)
      response.body[collection_name] if response.code =~ /200/
    end

    def klass_name(klass)
      klass.to_s.split('::')[-1]
    end

    def service
      self.class.service
    end
  end
end
