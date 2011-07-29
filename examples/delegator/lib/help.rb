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
      if args.size != 1
        puts Quickl.help(Quickl.super_command(self))
      else
        cmd = Quickl.subcommand!(Quickl.super_command(self), args.first)
        puts Quickl.help(cmd)
      end
    end
    
  end # class Help
end # class Delegator
