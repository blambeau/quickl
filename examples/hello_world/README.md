# Minicom example: hello_world 

This example shows how to create a really simple commandline program. 

## Structure

The structure it follows is simply:

    #
    # Short description here
    #
    # SYNOPSIS
    #   Usage: ...
    #
    # DESCRIPTION
    #   Long description here...
    #
    class SimpleCommand < Minicom::Command(__FILE__, __LINE__)
    
      # install options below
      options do |opt|
        # _opt_ is an OptionParser instance
      end
      
      # install the code to run the command
      def execute(args)
        # _args_ are non-option command line parameters
      end
    
    end
    
    # To run the command, typically in a bin/simple_command 
    # shell file
    SimpleCommand.run(ARGV)
    

## Example

Try the following:

    ./hello_world 
    ./hello_world bob
    ./hello_world --capitalize
    ./hello_world --capitalize bob
    ./hello_world --version
    ./hello_world --help
    ./hello_world too many arguments
    ./hello_world --no-such-option 

## What's magic in here?

* Documentation shown with --help is the rdoc documentation evaluated
  in the binding of the SimpleCommand class. You can use #{...} to
  display specific things.
* Default error handlers are installed by default to catch Interrupt
  Minicom::Exit and OptionParser::Error. See error_handling example
  to learn more about them
