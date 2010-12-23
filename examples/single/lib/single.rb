begin 
  require 'minicom'
rescue LoadError
  $LOAD_PATH.unshift File.expand_path('../../../../lib', __FILE__)
  require 'minicom'
end

#
# Single command line
#
# Usage: single [options] ARGS...
# 
# This example illustrates how to write a single command line 
# with options and additional arguments.
#
class Single < Minicom::Command(__FILE__, __LINE__)

  # Single command version
  VERSION = "0.1.0"

  # Install command options
  option_builder do |opt|
    
    # Show the help and exit
    opt.on_tail("--help", "Show help") do
      puts_and_exit opt
    end

    # Show version and exit
    opt.on_tail("--version", "Show version") do
      puts_and_exit "single " << VERSION << " (c) 2010, Bernard Lambeau"
    end
    
  end # option_builder
  
  # Normal command execution
  def execute(args)
    puts "Running on #{args.inspect}"
  end
  
end # class Single