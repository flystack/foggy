module Foggy
  module Collections
    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end

    def class_exists?(name)
      return true if !!self.const_get(name)
    rescue
      false
    end

    # class Foggy::Networking::Subnets
    #   include Foggy::Collection
    # end
    def create_collection_class(collection_name)
      unless class_exists?(collection_name)
        self.const_set(collection_name, Class.new do
          include Foggy::Collection
        end)
      end
    end

    # class Foggy::Networking::Subnets::Subnet
    #   include Foggy::Element
    # end
    def create_element_class(collection_name, element_name)
      klass = self.const_get(collection_name)
      klass.const_set(element_name, Class.new do
        include Foggy::Element
      end)
    end

    # Unless an element_name is provided, the singular name of a collection is deducted from its collection name:
    # - When a name ends with 'ies' it will be replaced with 'y'
    # - Otherwise the last letter is removed
    def define(collection_name, element_name = nil)
      element_name ||= singular(collection_name, element_name)
      create_collection_class(collection_name.to_s.capitalize)
      create_element_class(collection_name.to_s.capitalize, element_name.capitalize)

      # def subnets
      #   @subnets ||= Foggy::Networking::Subnets.new("subnet")
      # end
      klass = self.const_get(collection_name.capitalize)
      define_method("#{collection_name}") do
        unless instance_variable_defined?("@#{collection_name}")
          instance_variable_set("@#{collection_name}", klass.new(element_name))
        end
        return instance_variable_get("@#{collection_name}")
      end
    end

    def singular(plural_name, single_name)
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
  end
end
