class Delegate
  # 
  # Show help about a specific command
  #
  # SYNOPSIS
  #   delegate help COMMAND
  #
  class Help < Quickl::Command(__FILE__, __LINE__)
    
    # Command execution
    def execute(args)
      if args.size != 1
        puts super_command.help
      else
        cmd = has_command!(args.first, super_command)
        puts_and_exit cmd.documentation
      end
    end
    
  end # class Help
end # class Delegate