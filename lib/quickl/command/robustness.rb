module Quickl
  class Command
    module Robustness
      include Naming
      
      # Checks that a command whose name is given exists
      # or raises a NoSuchCommand.
      def has_command!(name, referer = self.class)
        name.split(':').inject(referer){|cur,look|
          cur.const_get(command2module(look))
        }
      rescue NameError => ex
        raise NoSuchCommand, "No such command #{name}", ex.backtrace
      end
      
    end # module Robustness
  end # class Command
end # module Quickl