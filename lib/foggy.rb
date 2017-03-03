require 'misty'

module Foggy
  class Cloud
    def initialize(cloud)
      @cloud = cloud
    end

    def alarming
      @alarming ||= Foggy::Service::Alarming.new(@cloud.alarming)
    end

    def baremetal
      @baremetal ||= Foggy::Service::Baremetal.new(@cloud.baremetal)
    end

    def block_storage
      @block_storage ||= Foggy::Service::BlockStorage.new(@cloud.block_storage)
    end

    alias volume block_storage

    def clustering
      @clustering ||= Foggy::Service::Clustering.new(@cloud.clustering)
    end

    def compute
      @compute ||= Foggy::Service::Compute.new(@cloud.compute)
    end

    def container
      @container ||= Foggy::Service::Container.new(@cloud.container)
    end

    def data_protection
      @data_protection ||= Foggy::Service::DataProtection.new(@cloud.data_protection)
    end

    def data_processing
      @data_processing ||= Foggy::Service::DataProcessing.new(@cloud.data_processing)
    end

    def database
      @database ||= Foggy::Service::Database.new(@cloud.database)
    end

    def dns
      @dns ||= Foggy::Service::DNS.new(@cloud.dns)
    end

    def identity
      @identity ||= Foggy::Service::Identity.new(@cloud.identity)
    end

    def image
      @image ||= Foggy::Service::Image.new(@cloud.image)
    end

    def messaging
      @messaging ||= Foggy::Service::Messaging.new(@cloud.messaging)
    end

    def metering
      @metering ||= Foggy::Service::Metering.new(@cloud.metering)
    end

    def network
      @network ||= Foggy::Service::Network.new(@cloud.network)
    end

    def object_storage
      @object_storage ||= Foggy::Service::ObjectStorage.new(@cloud.object_storage)
    end

    def orchestration
      @orchestration ||= Foggy::Service::Orchestration.new(@cloud.orchestration)
    end

    def search
      @search ||= Foggy::Service::Search.new(@cloud.search)
    end

    def shared_file_systems
      @shared_file_systems ||= Foggy::Service::SharedFileSystems.new(@cloud.shared_file_systems)
    end
  end
end
