require 'minicom/command/builder'
require 'minicom/command/robustness'
module Minicom
  class Command
    
    # Methods installed on all command classes
    module ClassMethods
      
      # The super command, if any
      attr_accessor :super_command
      
      # Command's summary
      attr_accessor :summary
      
      # Command's usage
      attr_accessor :usage
      
      # Command's description
      attr_accessor :description
      
      # Returns the array of defined subcommands
      def subcommands
        @subcommands ||= []
      end
      
      # Returns true if this command has at least one 
      # subcommand
      def has_sub_commands?
        @subcommands and !@subcommands.empty?
      end
      
      # Runs the command
      def run(file = '.', argv = [])
        self.new.run(file, argv)
      end
      
    end # module ClassMethods
    
    # Methods installed on all command instances
    module InstanceMethods

      #
      # Runs the command from a requester file with command-line
      # arguments.
      #
      # This method is intended to be overriden and does nothing
      # by default.
      #
      def run(file = '.', argv = [])
      end
    
    end # module InstanceMethods
    
    # Tracks child classes
    def self.inherited(command)
      Minicom.build_command(command)
    end
    
  end # class Command
end # module Minicom
require 'minicom/command/delegate'
