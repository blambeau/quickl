require 'optparse'
require 'quickl/command/class_methods'
require 'quickl/command/instance_methods'
module Quickl
  class Command
    extend Naming
    
    # Tracks child classes
    def self.inherited(command)
      Quickl.build_command(command)
    end
    
  end # class Command
end # module Quickl
require 'quickl/command/builder'
require 'quickl/command/options'
require 'quickl/command/single'
require 'quickl/command/delegator'
