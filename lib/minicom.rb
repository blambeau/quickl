require 'minicom/ruby_tools'
require 'minicom/command'
module Minicom

  # Minicom VERSION
  VERSION = '0.1.0'
  
  # Checks if _who_ looks a command
  def self.looks_a_command?(who)
    who.ancestors.include?(Command)
  end
  
  # Yields the block with the current command builder.
  # A new builder is created if required
  def self.command_builder 
    @builder ||= Command::Builder.new
    yield @builder if block_given?
    @builder
  end
  
  # Builds _command_ using the current builder. 
  #
  # The builder is considered consumed and removed as
  # a side effect. 
  def self.build_command(command)
    unless @builder
      raise "No command builder currently installed"
    else
      @builder.run(command)
      @builder = nil
    end
  end
  
  # Helper to create command with attached 
  # documentation
  def self.Command(*args)
    command_builder do |b|
      b.document *args
    end
    Command
  end
  
end # module Minicom
