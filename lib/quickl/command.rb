require 'optparse'
module Quickl
  class Command
    extend Naming
    
    # Methods installed on all command classes
    module ClassMethods
      
      # The super command, if any
      attr_accessor :super_command
      
      # Command's summary
      attr_accessor :doc_place
      
      # Returns the array of defined subcommands
      def subcommands
        @subcommands ||= []
      end
      
      # Returns true if this command has at least one 
      # subcommand
      def has_sub_commands?
        @subcommands and !@subcommands.empty?
      end
      
      ############################################### Textual information about the command 
      
      # Returns command name
      def command_name
        module2command(self)
      end
      
      # Loads and returns the documentation source
      def doc_src
        @doc_src ||= unless doc_place
          "no documentation available" 
        else
          file, line = doc_place
          RubyTools::extract_file_rdoc(file, line, true)
        end
      end
      
      # Returns command documentation
      def documentation
        @documentation ||= instance_eval("%Q{#{doc_src}}", *doc_place)
      end
      alias :help :documentation
      
      # Returns command usage
      def usage
        doc = documentation.split("\n")
        doc.each_with_index{|line,i|
          case line
            when /Usage:/ 
              return line.strip
            when /SYNOPSIS/
              return doc[i+1].strip || "no usage available"
          end
        } 
        "no usage available"
      end
      
      # Returns command overview
      def overview
        doc = documentation.split("\n")
        doc.find{|s| !s.strip.empty?} || "no overview available"
      end
      
      # Runs the command
      def run(*args)
        self.new.run(*args)
      end
      
      ############################################### Error handling 
      
      # Bypass reaction to some exceptions
      def no_react_to(*args)
        @no_react_to ||= []
        @no_react_to += args
      end
      
      # Should I bypass reaction to a given error?
      def no_react_to?(ex)
        @no_react_to && @no_react_to.find{|c|
          ex.is_a?(c)
        }
      end
      
      # Should I react to a given error?
      def react_to?(ex)
        !no_react_to?(ex)
      end
      
      ############################################### Hooks
      
      # Wraps command execution with a block if some filter is
      # true
      def wrap(filter = nil, &block)
        @wrapper = [filter, block]
      end
      
      # Returns the wrapper code
      def wrapper(command)
        return nil unless @wrapper
        filter, block = @wrapper
        lambda{|cont|
          if !filter || command.instance_eval(&filter)
            block.call(cont)
          else
            cont.call
          end
        }
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
      
      # Handles a command error
      def handle_error(ex)
        if react_to?(ex)
          begin
            ex.command = self
            ex.react!
          rescue Quickl::Error => ex2
            handle_error(ex2)
          end
        else
          raise ex
        end
      end
      
      # Returns code execution wrapper
      def wrapper
        self.class.wrapper(self) || lambda{|cont| cont.call}
      end
      
      # Executes the block inside the wrapping code
      def execute_wrapping(&block)
        wrapper.call(block)
      end

      #
      # Runs the command from a requester file with command-line
      # arguments.
      #
      # This method is intended to be overriden and does nothing
      # by default.
      #
      def run(argv)
        _run(argv)
      rescue Quickl::Error => ex
        handle_error(ex)
      end
    
    end # module InstanceMethods
    
    # Tracks child classes
    def self.inherited(command)
      Quickl.build_command(command)
    end
    
  end # class Command
end # module Quickl
require 'quickl/command/builder'
require 'quickl/command/robustness'
require 'quickl/command/options'
require 'quickl/command/single'
require 'quickl/command/delegate'
