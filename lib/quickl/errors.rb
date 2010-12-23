module Quickl
  
  # Main class of all Quickl's errors
  class Error < StandardError
    
    # Quickl command under execution
    attr_accessor :command
    
  end # class Error
  
  # Marker to tell that the command should exit
  class Exit < Error
    
    # Exit code
    attr_reader :exit_code
    
    # Creates an Exit instance
    def initialize(exit_code)
      @exit_code = exit_code
    end
    
    # Default behavior is to invoke Kernel.exit
    # with the exit code provided at construction
    def react!
      Kernel.exit(exit_code)
    end
    
  end # class Exit
  
  # Marker to tell that the command should exit
  class Help < Error
    
    # Exit code
    attr_reader :exit_code
    
    # Creates a Help instance
    def initialize(exit_code = 0)
      @exit_code = exit_code
    end
    
    # Default behavior is to print command help
    # then re-raise an Exit with same exit code.
    def react!
      out = (exit_code < 0 ? $stderr : $stdout)
      out.puts command.help
      raise Exit, exit_code
    end
    
  end # class Help
  
  # Raised when a command cannot be found
  class NoSuchCommandError < Error 
    
    # Default behavior is to reraise a Help(-1)
    def react!
      raise Help, -1
    end
    
  end # class NoSuchCommandError
  
end # module Quickl