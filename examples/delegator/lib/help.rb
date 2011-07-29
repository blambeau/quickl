class Delegator
  # 
  # Show help about a specific command
  #
  # SYNOPSIS
  #   #{program_name} #{command_name} help COMMAND
  #
  class Help < Quickl::Command(__FILE__, __LINE__)
    
    # Let NoSuchCommandError be passed to higher stage
    no_react_to Quickl::NoSuchCommand
    
    # Command execution
    def execute(args)
      sup = Quickl.super_command(self)
      sub = (args.size != 1) ? sup : Quickl.subcommand!(sup, args.first)
      puts Quickl.help(sub)
    end
    
  end # class Help
end # class Delegator
