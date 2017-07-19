require "foggy/collections"

module Foggy
  class Backup
    extend Foggy::Collections

    define :actions
    define :backups
    define :jobs
    define :sessions
  end
end
