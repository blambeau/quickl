require 'minicom/ruby_tools'
require 'minicom/catalog'
require 'minicom/command'
module Minicom

  # Minicom VERSION
  VERSION = '0.1.0'
  
  # Checks if _who_ looks a command catalog
  def self.looks_a_catalog?(who)
    who.ancestors.include?(Catalog)
  end
  
  # Checks if _who_ looks a command
  def self.looks_a_command?(who)
    who.ancestors.include?(Command)
  end
  
  # Installs documentation tracking info
  def self.install_tracking(file, line)
    @tracking = [file, line]
  end
  
  # Is documentation tracking information currently 
  # installed ?
  def self.has_tracking?
    @tracking
  end
  
  # Consumes tracking information currently installed
  def self.consume_tracking
    unless has_tracking?
      raise "No documentation tracking information installed"
    else
      yield(*@tracking)
      @tracking = nil
    end
  end
  
  # Helper to create command with attached 
  # documentation
  def self.Command(file, line)
    install_tracking(file, line)
    Command
  end
  
  # Helper to create catalog with attached 
  # documentation
  def self.Catalog(file, line)
    install_tracking(file, line)
    Catalog
  end
  
end # module Minicom
