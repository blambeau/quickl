module Minicom
  
  # Instance method for being a single command
  module Command::Single
    
    # Command arguments after options parsing
    attr_reader :args

    # Run the command by delegation
    def run(argv = [])
      args = options.parse!(argv)
      self.class.executions.reverse.each{|exec|
        exec.call(args)
      }
    end
    
  end # module Command::Delegate
  
  #
  # Create a delegate command
  #
  def self.Command(*args)
    command_builder do |b|
      b.document *args
      b.instance_module Command::Single
    end
    Command
  end
  
end # module Minicom