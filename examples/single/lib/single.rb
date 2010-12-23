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

  # Show the help and exit
  options.on_tail("--help", "Show help") do
    execute_and_exit{ 
      puts help 
    }
  end

  # Show version and exit
  options.on_tail("--version", "Show version") do
    execute_and_exit{ 
      puts "single " << VERSION << " (c) 2010, Bernard Lambeau"
    }
  end
  
  # Normal command execution
  execute do |args|
    puts "Running on #{args.inspect}"
  end
  
end # class Single