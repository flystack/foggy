require 'misty'

module Foggy
  class Cloud
    def initialize(*args)
      @cloud = Misty::Cloud.new(*args)
    end

    def build_service(klass, service)
      klass.create_method(:service) { service }
      klass.new
    end

    def alarming
      @alarming ||= build_service(Foggy::Alarming, @cloud.alarming)
    end

    def application_catalog
      @application_catalog ||= build_service(Foggy::ApplicationCatalog, @cloud.application_catalog)
    end

    def backup
      @backup ||= build_service(Foggy::Backup, @cloud.backup)
    end

    def baremetal
      @baremetal ||= build_service(Foggy::Baremetal, @cloud.baremetal)
    end

    def block_storage
      @block_storage ||= build_service(Foggy::BlockStorage, @cloud.block_storage)
    end

    def clustering
      @clustering ||= build_service(Foggy::Clustering, @cloud.clustering)
    end

    def compute
      @compute ||= build_service(Foggy::Compute, @cloud.compute)
    end

    def container
      @container ||= build_service(Foggy::Container, @cloud.container)
    end

    def data_processing
      @data_processing ||= build_service(Foggy::DataProcessing, @cloud.data_processing)
    end

    def data_protection
      @data_protection ||= build_service(Foggy::DataProtection, @cloud.data_protection)
    end

    def database
      @database ||= build_service(Foggy::Database, @cloud.database)
    end

    def dns
      @dns ||= build_service(Foggy::DNS, @cloud.dns)
    end

    def identity
      @identity ||= build_service(Foggy::Identity, @cloud.identity)
    end

    def image
      @image ||= build_service(Foggy::Image, @cloud.image)
    end

    def messaging
      @messaging ||= build_service(Foggy::Messaging, @cloud.messaging)
    end

    def metering
      @metering ||= build_service(Foggy::Metering, @cloud.metering)
    end

    def networking
      @metering ||= build_service(Foggy::Networking, @cloud.networking)
    end

    def nvf_orchestration
      @nvf_orchestration ||= build_service(Foggy::NFVOrchestration, @cloud.nvf_orchestration)
    end

    def object_storage
      @object_storage ||= build_service(Foggy::ObjectStorage, @cloud.object_storage)
    end

    def orchestration
      @orchestration ||= build_service(Foggy::Orchestration, @cloud.orchestration)
    end

    def search
      @search ||= build_service(Foggy::Search, @cloud.search)
    end

    def shared_file_systems
      @shared_file_systems ||= build_service(Foggy::SharedFileSystems, @cloud.shared_file_systems)
    end
  end
end
