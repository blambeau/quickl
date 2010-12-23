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
      
      # Puts something and exit
      def puts_and_exit(what, exit_code = 0)
        puts what
        raise Quickl::Exit.new(exit_code)
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
      rescue Exception => ex
        self.class.handle_error(ex, self)
      end
    
    end # module InstanceMethods
    
    # Tracks child classes
    def self.inherited(command)
      Quickl.build_command(command)
    end
    
  end # class Command
end # module Quickl
require 'quickl/command/builder'
require 'quickl/command/error_handling'
require 'quickl/command/robustness'
require 'quickl/command/options'
require 'quickl/command/single'
require 'quickl/command/delegate'
