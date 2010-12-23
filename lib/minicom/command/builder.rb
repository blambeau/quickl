module Minicom
  class Command
    class Builder
      
      # Adds document tracking information
      def document(file, line)
        @file, @line = file, line
      end
      
      # Adds some command class modules
      def class_modules(*mods)
        @class_modules ||= [ 
          Command::ClassMethods,
          Command::Options::ClassMethods,
          Command::ErrorHandling
        ]
        @class_modules += mods
      end
      alias :class_module class_modules
      
      # Adds some command instance modules
      def instance_modules(*mods)
        @instance_modules ||= [ 
          Command::InstanceMethods, 
          Command::Robustness,
          Command::Options::InstanceMethods
        ]
        @instance_modules += mods
      end
      alias :instance_module instance_modules
      
      # Installs on a command subclass
      def run(command)
        # install class and instance methods
        class_modules.each{|mod|
          command.extend(mod)
        }
        instance_modules.each{|mod|
          command.instance_eval{ include mod } 
        }
      
        # install documentation
        if @file and @line
          command.doc_place = [@file, @line]
        end
        
        # install error handlers
        command.default_error_handlers

        # install hierarchy
        parent = RubyTools::parent_module(command)
        if parent && Minicom.looks_a_command?(parent)
          command.super_command = parent
          parent.subcommands << command
        end
      
        command
      end
      
    end # class Builder
  end # class Command
end # module Minicom