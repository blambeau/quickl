module Quickl
  class Command
    class Builder
      
      # Adds document tracking information
      def document(*args)
        @doc_place = args
      end
      
      # Adds some command class modules
      def class_modules(*mods)
        @class_modules ||= [ 
          Command::ClassMethods,
          Command::Options::ClassMethods,
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
      
      # Sets the parent of the command currently built
      def command_parent=(p)
        @parent = p
      end
      
      # Installs a callback block to execute at 
      # install time
      def callback(&block)
        @callbacks ||= []
        @callbacks << block
      end
      
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
        if @doc_place
          command.doc_place = @doc_place
        end

        # install hierarchy
        parent = (defined?(@parent) && @parent) || RubyTools::parent_module(command)
        if parent && parent.ancestors.include?(Command)
          command.super_command = parent
          parent.subcommands << command
        end
        
        # execute callbacks
        Array(@callbacks).each do |blk|
          blk.call(command)
        end if defined?(@callbacks)
      
        command
      end
      
    end # class Builder
  end # class Command
end # module Quickl
