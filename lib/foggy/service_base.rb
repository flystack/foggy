module Foggy
  class ServiceBase
    def initialize(service)
      @service = service
    end
  end

  module Service
    class Alarming < Foggy::ServiceBase;  end

    class Baremetal < Foggy::ServiceBase; end

    class BlockStorage < Foggy::ServiceBase; end

    class Clustering < Foggy::ServiceBase; end

    class Compute < Foggy::ServiceBase; end

    class Container < Foggy::ServiceBase; end

    class DataProtection < Foggy::ServiceBase; end

    class DataProcessing < Foggy::ServiceBase; end

    class Database < Foggy::ServiceBase; end

    class DNS < Foggy::ServiceBase; end

    class Identity < Foggy::ServiceBase; end

    class Image < Foggy::ServiceBase; end

    class Messaging < Foggy::ServiceBase; end

    class Metering < Foggy::ServiceBase; end

    class ObjectStorage < Foggy::ServiceBase; end

    class Orchestration < Foggy::ServiceBase; end

    class Search < Foggy::ServiceBase; end

    class SharedFileSystems < Foggy::ServiceBase; end
  end
end
