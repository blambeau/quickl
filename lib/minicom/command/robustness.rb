module Minicom
  class Command
    module Robustness
      include Naming
      
      # Checks that a command whose name is given exists
      # or raises a NoSuchCommandError.
      def has_command!(name, referer = self.class)
        name.split(':').inject(referer){|cur,look|
          cur.const_get(command2module(look))
        }
      rescue NameError => ex
        raise NoSuchCommandError, "No such command #{name}", ex.backtrace
      end
      
    end # module Robustness
  end # class Command
end # module Minicom
  