module Foggy
  module Collection
    def initialize(service, element)
      @element = element
      # For example: Foggy::Networking::
      @element_klass = self.class.const_get(@element.capitalize)
      @service = service
      @collection = build
    end

    def all
      @collection
    end

    def get(id)
      element = fetch(id)
      if element
        @element_klass.new(element)
      end
    end

    def reload
      @collection = fetch_all
    end

    private

    def self.create_element_class
      unless class_exists?(name.capitalize)
        self.const_set(name.capitalize, Class.new do
          include Foggy::Element
        end)
      else
        raise RuntimeError, "Error: #{self}::#{name.capitalize} already defined"
      end
    end

    def build
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
      self.class.to_s.split('::')[-1].downcase
    end

    def collection_prefix
      self.class.to_s.split('::')[-1].downcase
    end

    def fetch_all
      response = @service.send(name_fetch_all)
      response.body[collection_name] if response.code =~ /200/
    end

    def fetch(id)
      response = @service.send(name_fetch_element, id)
      response.body[@element] if response.code =~ /200/
    end

    def name_fetch_all
      "list_#{collection_name}"
    end

    def name_fetch_element
      "show_#{@element}_details"
    end

    def service_class
      project = @service.class.to_s.split('::')[-2]
      Misty.services.each do |e|
        return e.name.to_s if e.project == project.downcase.to_sym
      end
    end
  end
end
