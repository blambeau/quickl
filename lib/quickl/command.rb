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
      
      # Returns a subcommand by its name, or nil
      def subcommand_by_name(name)
        return nil unless has_sub_commands?
        look  = name.split(':')
        found = subcommands.find{|cmd| cmd.command_name == look.first}
        if found.nil? or (look.size == 1)
          return found 
        else
          found.subcommand_by_name(look[1..-1].join(':'))
        end
      end
      
      # Returns true if this command has at least one 
      # subcommand
      def has_sub_commands?
        @subcommands and !@subcommands.empty?
      end
      
      ############################################### Textual information about the command 
      
      # Returns name of the program under execution
      def program_name
        File.basename($0)
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
      def run(argv = [], requester = nil)
        cmd = self.new
        cmd.run(argv, requester)
      rescue Quickl::Error => ex
        handle_error(ex, cmd)
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
      
      # Handles a command error
      def handle_error(ex, cmd = self)
        if react_to?(ex)
          begin
            ex.command = cmd
            ex.react!
          rescue Quickl::Error => ex2
            handle_error(ex2, cmd)
          end
        else
          raise ex
        end
      end
  
    end # module ClassMethods
    
    # Methods installed on all command instances
    module InstanceMethods
      
      # Who is requesting command execution?
      attr_reader :requester
      
      # Delegate unrecognized calls to the command class
      # (gives access to options, help, usage, ...)
      def method_missing(name, *args, &block)
        if self.class.respond_to?(name)
          if $VERBOSE
            STDERR << "WARN (Quickl): #{name} is deprecated, use self.class.#{name} "\
                      "(#{caller.first})\n"
          end
          self.class.send(name, *args, &block)
        else
          super
        end
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
require 'quickl/command/delegator'
