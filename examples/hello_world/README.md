# Quickl example: hello_world 

This example shows how to create a really simple commandline program. 

## Structure

The structure it follows is simply:

    #
    # Short description here
    #
    # SYNOPSIS
    #   Usage: ...
    #
    # OPTIONS:
    # #{sumarized_options}
    #
    # DESCRIPTION
    #   Long description here...
    #
    class SimpleCommand < Quickl::Command(__FILE__, __LINE__)
    
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
    # => Hello world!
    
    ./hello_world --capitalize
    # => Hello World!

    ./hello_world bob
    # => Hello bob!
    
    ./hello_world --capitalize bob
    # => Hello Bob!
    
    ./hello_world --version
    # => hello_world 0.1.0 (c) 2010, Bernard Lambeau
    
    ./hello_world --help
    # => ...
    
    ./hello_world too many arguments
    # => needless argument: too many arguments
    # => hello_world [--help] [--version] [--capitalize] [WHO]
    
    ./hello_world --no-such-option 
    # invalid option: --no-such-option
    # hello_world [--help] [--version] [--capitalize] [WHO]

## You have to known that ...

* An **instance** of command is actually executed. Therefore, it is safe to install instance variables through options and to use them in execute().
* Documentation shown with --help is the rdoc documentation evaluated in the binding of the SimpleCommand **class**. Therefore, you can use #{...} to display specific things (like #{sumarized_options}).
* Default error handlers are installed by default to catch Interrupt, Quickl::Exit and OptionParser::Error. See error_handling example to learn more about them.
