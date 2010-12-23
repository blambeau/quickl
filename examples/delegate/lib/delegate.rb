require File.expand_path('../../../helper', __FILE__)

#
# Usage: delegate [--version] [--help] COMMAND [cmd opts] ARGS...
#
# Options are: 
# #{summarized_options} 
#
# Show how to write a delegate command
#
class Delegate < Minicom::Delegate(__FILE__, __LINE__)

  # Single command version
  VERSION = "0.1.0"
  
  # Copyright
  COPYRIGHT = "#{VERSION} (c) 2010, Bernard Lambeau"

  # Install command options
  option_builder help_and_version(COPYRIGHT)
 
  # 
  # Usage: delegate help COMMAND
  # 
  # Show help about a specific command
  #
  class Help < Minicom::Command(__FILE__, __LINE__)
    
    # Install command options
    option_builder help_and_version(COPYRIGHT)
  
    # Command execution
    def execute(args)
      if args.size != 1
        puts_and_exit super_command.documentation
      else
        puts has_command!(args.first, super_command).documentation
      end
    end
    
  end # class Help
  
  # 
  # Say hello to the first command argument
  #
  # Usage: delegate [opts] hello WHO...
  #
  class Hello < Minicom::Command(__FILE__, __LINE__)
    
    # Install command options
    option_builder help_and_version(COPYRIGHT)

    # Command execution
    def execute(args)
      puts "Hello #{args.join(' and ')}"
    end
    
  end # class Hello
  
end # class Single