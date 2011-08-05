module Quickl
  class Command
    class Builder
      
      # The super command, if any
      attr_accessor :super_command
      alias :"command_parent=" :"super_command="
      
      # Extractor for documentation
      attr_accessor :doc_extractor
      
      # Instantiator for documentation
      attr_accessor :doc_instantiator
      
      # Sets place of the documentation
      def document(file, line)
        @doc_extractor = lambda{|cmd|
          RubyTools::extract_file_rdoc(file, line, true) 
        }
        @doc_instantiator = lambda{|cmd,text|
          cmd.instance_eval("%Q{#{text}}", file, line)
        }
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
        self.doc_extractor    ||= lambda{|cmd| "no documentation available for #{cmd}" }
        self.doc_instantiator ||= lambda{|cmd,text| text}
        command.doc_extractor = doc_extractor
        command.doc_instantiator = doc_instantiator

        # install hierarchy
        self.super_command ||= RubyTools::parent_module(command)
        if super_command && super_command.ancestors.include?(Command)
          command.super_command = super_command
          super_command.subcommands << command
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
