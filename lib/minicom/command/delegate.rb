module Minicom
  
  # Instance method for being a delegate command
  module Command::Delegate
    
    # Run the command by delegation
    def run(argv = [])
      # My own options
      my_argv = []
      while argv.first =~ /^--/
        my_argv << argv.shift
      end
      
      # Run the subcommand now
      has_command!(argv.shift).run(argv)
    end
    
  end # module Command::Delegate
  
  #
  # Create a delegate command
  #
  def self.Delegate(*args)
    command_builder do |b|
      b.document *args
      b.instance_module Command::Delegate
    end
    Command
  end
  
end # module Minicom