require 'optparse'
module Minicom
  class Command
    
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
        @documentation ||= instance_eval("%Q{#{doc_src}}")
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
        raise Minicom::Exit.new(exit_code)
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
      Minicom.build_command(command)
    end
    
  end # class Command
end # module Minicom
require 'minicom/command/builder'
require 'minicom/command/error_handling'
require 'minicom/command/robustness'
require 'minicom/command/options'
require 'minicom/command/single'
require 'minicom/command/delegate'
