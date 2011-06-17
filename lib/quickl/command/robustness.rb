module Quickl
  class Command
    module Robustness
      include Naming
      
      # Checks that a command whose name is given exists
      # or raises a NoSuchCommand.
      def has_command!(name, referer = self.class)
        unless cmd = referer.subcommand_by_name(name)
          raise NoSuchCommand, "No such command #{name}" 
        end
        cmd
      end
      
      # Checks that _file_ is a readable file or raises an error.
      # Returns _file_ on success.
      def valid_read_file!(file, error_class = nil, msg = nil)
        if File.file?(file) and File.readable?(file)
          file
        else
          error_class ||= Quickl::IOAccessError
          msg ||= "Not a file or not readable: #{file}"
          raise error_class, msg, caller
        end
      end
      
    end # module Robustness
  end # class Command
end # module Quickl