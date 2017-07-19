require "foggy/collections"

module Foggy
  class Baremetal
    extend Foggy::Collections

    define :chassis
    define :nodes
    define :ports
    define :portgroups
  end
end
