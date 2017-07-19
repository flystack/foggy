module Foggy
  module Element
    def self.getter(key)
      define_method(key) do
        instance_variable_get("@#{key}")
      end
    end

    def self.setter(key, value)
      define_method("#{key}=") do |value|
        instance_variable_set("@#{key}", value)
      end
    end

    def initialize(element)
      create_setters(element)
    end

    def delete
      api_delete_element = "delete_#{klass_name.downcase}".to_sym
      response = service.send(api_delete_element, id)
    end

    def save
      api_update_element = "update_#{klass_name.downcae}".to_sym
      #latest = fetch(id)
      #delta = latest - self
      #service.send(api_update_element, id, delta)
    end

    private
    # TODO: factor
    def klass_name
      self.class.to_s.split('::')[-1]
    end

    def service
      klass = self.class.to_s.split('::')[1]
      Foggy.const_get(klass).service
    end

    def create_attribute(key, value)
      instance_variable_set("@#{key}", value)
      Foggy::Element.setter(key, value)
      Foggy::Element.getter(key)
    end

    def create_setters(element)
      element.each do |key, value|
        if key =~ /:/
          if composed = key.match(/(.*):(.*)/)
            var_name = "@#{composed[1]}"
            if instance_variable_defined?(var_name)
              initial = instance_variable_get(var_name)
              instance_variable_set(var_name, initial.merge(composed[2] => value))
            else
              create_attribute(composed[1], composed[2] => value)
            end
          end
        else
          create_attribute(key, value) unless instance_variable_defined?("@#{key}")
        end
      end
    end
  end
end
