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
        puts self.class.super_command.help
      else
        cmd = Quickl.has_subcommand!(self.class.super_command, args.first)
        puts cmd.help
      end
    end
    
  end # class Help
end # class Delegator
