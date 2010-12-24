# Quickl example: delegate

This example shows how to delegate commands. Delegate commands are command
that delegate the actual execution to sub commands (well known example is
'git'). A delegate command typically has a signature like:

    delegate [main options] COMMAND [cmd options] ARGS...

## Structure

The structure for delegate commands is as follows:

    #
    # Main command overview
    #
    # SYNOPSIS
    #   Usage: #{command_name} [main options] COMMAND [cmd options] ARGS...
    #
    # OPTIONS
    # #{sumarized_options}
    #
    # COMMANDS
    # #{summarized_commands}
    #
    # DESCRIPTION
    #   Long description here...
    #
    # See '#{command_name} help COMMAND' for more information on a specific command.
    #
    class DelegateCommand < Quickl::Delegate(__FILE__, __LINE__)
    
      # install options below
      options do |opt|
        # _opt_ is an OptionParser instance
      end
      
      #
      # Sub command overview
      # 
      # ...
      #
      class SubCommand1 < Quickl::Command(__FILE__, __LINE__)
      
        # [ ... ]
      
      end
      
      #
      # Sub command overview
      # 
      # ...
      #
      class SubCommand2 < Quickl::Command(__FILE__, __LINE__)
      
        # [ ... ]
      
      end
      
    end 
    
    # To run the command, typically in a bin/simple_command 
    # shell file
    DelegateCommand.run(ARGV)
    

## Example

Try the following:

    ./delegate 
    # => [ ... complete help with subcommands summary ... ]
    
    ./delegate --help
    # => [ ... complete help with subcommands summary ... ]
    
    ./delegate help 
    # => [ ... complete help with subcommands summary ... ]
    
    ./delegate help hello-world 
    # => [ ... help of hello-world's subcommand ... ]

    ./delegate hello-world bob
    # => Hello bob!
    
    ./hello_world --capitalize bob
    # => Hello Bob!