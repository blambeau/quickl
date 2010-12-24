require 'quickl/ext/object'
require 'quickl/errors'
require 'quickl/ruby_tools'
require 'quickl/naming'
require 'quickl/command'
module Quickl

  # Quickl VERSION
  VERSION = '0.1.0'.freeze
  
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
  
end # module Quickl
