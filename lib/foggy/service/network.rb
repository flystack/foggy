require 'foggy/service_base'

module Foggy
  module Service
    class Network < Foggy::ServiceBase
      define_collection "networks"
      define_collection "subnets"
      define_collection "routers"
    end
  end
end
