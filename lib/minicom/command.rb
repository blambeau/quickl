require 'optparse'
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
      
      # Build and return an OptionParser instance
      def options
        @options ||= OptionParser.new do |opt|
          opt.program_name = File.basename $0
          if const_defined?(:VERSION)
            opt.version = const_get(:VERSION)
          end
          opt.summary_indent = ' ' * 2
          opt.banner = self.usage
        end
        @options
      end
      
      # Returns command help
      def help
        options.to_s
      end
      
      # Runs the command
      def run(*args)
        self.new.run(*args)
      end
      
    end # module ClassMethods
    
    # Methods installed on all command instances
    module InstanceMethods

      # Delegate unrecognized calls to the command class
      # (gives access to options, help, usage, ...)
      def method_missing(name, *args, &block)
        if self.class.respond_to?(name)
          self.class.send(name, *args, &block)
        else
          super
        end
      end

      #
      # Runs the command from a requester file with command-line
      # arguments.
      #
      # This method is intended to be overriden and does nothing
      # by default.
      #
      def run(argv)
      end
    
    end # module InstanceMethods
    
    # Tracks child classes
    def self.inherited(command)
      Minicom.build_command(command)
    end
    
  end # class Command
end # module Minicom
require 'minicom/command/builder'
require 'minicom/command/robustness'
require 'minicom/command/hooks'
require 'minicom/command/single'
require 'minicom/command/delegate'
