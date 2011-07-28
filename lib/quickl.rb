require 'quickl/loader'
require 'quickl/version'
require 'quickl/ext/object'
require 'quickl/errors'
require 'quickl/ruby_tools'
require 'quickl/naming'
require 'quickl/command'
module Quickl

  # Quickl's COPYRIGHT info 
  COPYRIGHT = "(c) 2010-2011, Bernard Lambeau"
  
  #
  # Prints a deprecation message on STDERR if $VERBOSE is set to true
  #
  def self.deprecated(who, instead, caller)
    if $VERBOSE
      STDERR << "WARN (Quickl): #{who} is deprecated, use #{instead} "\
                "(#{caller.first})\n"
    end
  end
  
  #
  # Yields the block with the current command builder.
  # A fresh new builder is created if not already done.
  #
  # This method is part of Quickl's private interface.
  #
  def self.command_builder 
    @builder ||= Command::Builder.new
    yield @builder if block_given?
    @builder
  end
  
  #
  # Builds _command_ using the current builder. 
  #
  # The current command builder is considered consumed 
  # and removed as a side effect. A RuntimeError is raised 
  # if no builder is currently installed.
  #
  # Returns the command itself.
  #
  # This method is part of Quickl's private interface.
  #
  def self.build_command(command)
    unless @builder
      raise "No command builder currently installed"
    else
      @builder.run(command)
      @builder = nil
      command
    end
  end
  
  #
  # Convenient method for <code>File.basename($0)</code>
  #
  def self.program_name
    File.basename($0)
  end
  
  #
  # Checks that `cmd` has a sub-command named `name` of raises a NoSuchCommand
  # error.
  #
  # @param [Class or Command] cmd a command instance of command class
  # @param [String] the name of a sub command
  # @return [Class] found subcommand class 
  #
  def self.has_subcommand!(cmd, name)
    case cmd
    when Class
      unless subcmd = cmd.subcommand_by_name(name)
        raise NoSuchCommand, "No such command #{name}" 
      end
      subcmd
    when Command
      has_subcommand!(cmd.class, name)
    else
      raise ArgumentError, "Not a recognized command #{cmd}"
    end
  end
  
end # module Quickl