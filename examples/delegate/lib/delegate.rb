#
# Delegate execution to a sub command
#
# SYNOPSIS
#   #{command_name} [--version] [--help] [--output=...] COMMAND [cmd opts] ARGS...
#
# OPTIONS
# #{summarized_options}
#
# COMMANDS
# #{summarized_subcommands}
#
# DESCRIPTION
#   This example shows how to write a delegate command, that is, a
#   command which delegates to a subcommand
#
# See '#{command_name} help COMMAND' for more information on a specific command.
#
class Delegate < Quickl::Delegate(__FILE__, __LINE__)

  # Single command version
  VERSION = "0.1.0"
  
  # Install options
  options do |opt|
    
    # Show the help and exit
    opt.on_tail("--help", "Show help") do
      raise Quickl::Help
    end

    # Show version and exit
    opt.on_tail("--version", "Show version") do
      raise Quickl::Exit, "#{opt.program_name} #{VERSION} (c) 2010, Bernard Lambeau"
    end

  end

end # class Delegate
require "help"
require "hello_world"
