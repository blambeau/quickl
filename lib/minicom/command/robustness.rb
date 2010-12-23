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
      
      # Raises an exception if args.size is greater than
      # max_size
      def needless_arguments!(args, max_size = 0)
        if args && args.size > max_size
          raise OptionParser::NeedlessArgument, args
        else
          args
        end
      end
      
    end # module Robustness
  end # class Command
end # module Minicom