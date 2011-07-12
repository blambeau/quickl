# Quickl example: delegator

This example shows how to create delegator commands. Delegators are commands
that delegate the actual execution to sub commands (well known example is
'git'). A delegator command typically has a signature like:

    delegator [main options] COMMAND [cmd options] ARGS...

## Structure

The structure for delegator commands is as follows:

    #
    # Main command overview
    #
    # SYNOPSIS
    #   Usage: #{command_name} [main options] COMMAND [cmd options] ARGS...
    #
    # OPTIONS
    # #{summarized_options}
    #
    # COMMANDS
    # #{summarized_subcommands}
    #
    # DESCRIPTION
    #   Long description here...
    #
    # See '#{command_name} help COMMAND' for more information on a specific command.
    #
    class DelegatorCommand < Quickl::Delegator(__FILE__, __LINE__)
    
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
    DelegatorCommand.run(ARGV)
    

## Example

Try the following:

    ./delegator
    # => [ ... complete help with subcommands summary ... ]
    
    ./delegator --help
    # => [ ... complete help with subcommands summary ... ]
    
    ./delegator help 
    # => [ ... complete help with subcommands summary ... ]
    
    ./delegator help hello-world 
    # => [ ... help of hello-world's subcommand ... ]

    ./delegator hello-world bob
    # => Hello bob!
    
    ./hello_world --capitalize bob
    # => Hello Bob!