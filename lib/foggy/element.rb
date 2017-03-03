module Foggy
  module Element
    def initialize(element)
      element.each do |key, value|
        if composite?(key)
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

    def create_attribute(key, value)
      instance_variable_set("@#{key}", value)
      Foggy::Element.setter(key, value)
      Foggy::Element.getter(key)
    end

    def composite?(name)
      true if name =~ /:/
    end
  end
end
