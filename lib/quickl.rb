require 'quickl/ext/object'
require 'quickl/errors'
require 'quickl/ruby_tools'
require 'quickl/naming'
require 'quickl/command'
module Quickl

  # Quickl's VERSION
  VERSION = '0.1.2'.freeze
  
  # Quickl's COPYRIGHT info 
  COPYRIGHT = "(c) 2010, Bernard Lambeau"
  
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
  
end # module Quickl
