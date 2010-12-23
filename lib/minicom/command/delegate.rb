module Minicom
  
  # Instance method for being a delegate command
  module Command::Delegate
    
    # Run the command by delegation
    def _run(argv = [])
      # My own options
      my_argv = []
      while argv.first =~ /^--/
        my_argv << argv.shift
      end
      options.parse!(my_argv)
      
      # Run the subcommand now
      if cmd = argv.shift
        has_command!(cmd).run(argv)
      else
        puts_and_exit usage + "\n" + summarized_options
      end
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