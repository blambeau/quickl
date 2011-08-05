require 'optparse'
module Quickl
  class Command
    module ClassMethods
      
      # The super command, if any
      attr_accessor :super_command
      
      # Extractor for documentation
      attr_accessor :doc_extractor
      
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
        Quickl.program_name
      end
      
      # Returns command name
      def command_name
        module2command(self)
      end
      
      # Returns command documentation
      def documentation(opts = {})
        @documentation ||= doc_extractor.call(self, opts)
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
        defined?(@no_react_to) && Array(@no_react_to).find{|c|
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
  end # class Command
end # module Quickl

