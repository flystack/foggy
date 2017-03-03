require 'misty'

module Foggy
  class Cloud
    def initialize(*args)
      @cloud = Misty::Cloud.new(*args)
    end

    private

    def method_missing(method_name, *args)
      # Equivalent of
      # @alarming ||= Foggy::Alarming.new(@cloud.alarming)
      if Misty.services.names.include?(method_name)
        klass = Foggy.const_get(method_name.capitalize)
        self.class.send(:define_method, method_name.to_s) do
          unless instance_variable_defined?("@#{method_name}")
            service = @cloud.send(method_name)
            instance_variable_set("@#{method_name}", klass.new(service))
          end
          return instance_variable_get("@#{method_name}")
        end
        return self.send(method_name)
      else
        raise "Undefined method #{method_name}"
      end
    end
  end
end
