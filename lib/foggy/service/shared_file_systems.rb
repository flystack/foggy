require "foggy/collections"

module Foggy
  class SharedFileSystems
    extend Foggy::Collections

    define :shares
    define :snapshots
    define :share_instances
    define :share_networks
    define :share_servers
    define :types
  end
end
