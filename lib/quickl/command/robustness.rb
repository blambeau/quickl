module Quickl
  class Command
    module Robustness
      include Naming
      
      # Checks that a command whose name is given exists
      # or raises a NoSuchCommand.
      def has_command!(name, referer = self.class)
        Quickl.deprecated("Command#has_command!", "Quickl.has_subcommand!", caller)
        Quickl.has_subcommand!(referer, name)
      end
      
      # Checks that _file_ is a readable file or raises an error.
      # Returns _file_ on success.
      def valid_read_file!(file, error_class = nil, msg = nil)
        Quickl.deprecated("Command#valid_read_file!", "Quickl.valid_read_file!", caller)
        Quickl.valid_read_file!(file, error_class, msg)
      end
      
    end # module Robustness
  end # class Command
end # module Quickl