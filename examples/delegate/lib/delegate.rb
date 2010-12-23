require File.expand_path('../../../helper', __FILE__)
#
# Delegate command line
#
# Usage: delegate [opts] COMMAND [cmd opts] ARGS...
# 
# This example illustrates how to write a delegate command line 
# with options and subcommand with its own options and arguments.
#
class Delegate < Minicom::Delegate(__FILE__, __LINE__)

  # Single command version
  VERSION = "0.1.0"
  
  # Copyright
  COPYRIGHT = "#{VERSION} (c) 2010, Bernard Lambeau"

  # Install command options
  option_builder help_and_version(COPYRIGHT)
    
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