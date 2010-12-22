module Minicom
  class Command
    class Builder
      
      # Adds document tracking information
      def document(file, line)
        @file, @line = file, line
      end
      
      # Adds some command class modules
      def class_modules(*mods)
        @class_modules ||= [ Command::ClassMethods ]
        @class_modules += mods
      end
      alias :class_module class_modules
      
      # Adds some command instance modules
      def instance_modules(*mods)
        @instance_modules ||= [ Command::InstanceMethods, Command::Robustness ]
        @instance_modules += mods
      end
      alias :instance_module instance_modules
      
      # Installs on a command subclass
      def run(command)
        # install class and instance methods
        class_modules.each{|mod|
          command.extend(ClassMethods)
        }
        instance_modules.each{|mod|
          command.instance_eval{ include mod } 
        }
      
        # install documentation
        if @file and @line
          rdoc = RubyTools::extract_file_rdoc(@file, @line, true)
          rdoc = RubyTools::rdoc_paragraphs(rdoc)
          command.summary     = (rdoc.shift || "")
          command.usage       = (rdoc.shift || "").strip
          command.description = rdoc.join("\n")
        end

        # install hierarchy
        parent = RubyTools::parent_module(command)
        if Minicom.looks_a_command?(parent)
          command.super_command = parent
          parent.subcommands << command
        end
      
        command
      end
      
    end # class Builder
  end # class Command
end # module Minicom