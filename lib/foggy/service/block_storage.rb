require "foggy/collections"

module Foggy
  class BlockStorage
    extend Foggy::Collections

    define :attachments
    define :group_snapshots
    define :group_types
    define :snapshots
    define :types
    define :volumes
  end
end
