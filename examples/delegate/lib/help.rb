class Delegate
  # 
  # Show help about a specific command
  #
  # SYNOPSIS
  #   delegate help COMMAND
  #
  class Help < Quickl::Command(__FILE__, __LINE__)
    
    # Let NoSuchCommandError be passed to higher stage
    no_react_to Quickl::NoSuchCommandError
    
    # Command execution
    def execute(args)
      if args.size != 1
        puts super_command.help
      else
        cmd = has_command!(args.first, super_command)
        puts cmd.help
      end
    end
    
  end # class Help
end # class Delegate