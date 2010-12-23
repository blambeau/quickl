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
    def initialize(msg, exit_code = 0)
      super(msg)
      @exit_code = exit_code
    end
    
    # Default behavior is to invoke Kernel.exit
    # with the exit code provided at construction
    def react!
      out = (exit_code < 0 ? $stderr : $stdout)
      out.puts self.message
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
      raise Exit.new(command.help, exit_code)
    end
    
  end # class Help
  
  # Raised when an option parsing occurs
  class OptionError < Error
    
    # Cause 
    attr_reader :cause
    
    # Creates an error with a cause (OptionParser::ParseError)
    def initialize(cause)
      @cause = cause
    end
    
    # Default behavior is to print cause's message
    # and reraise a Help
    def react!
      raise Exit.new("#{cause.message}\n#{command.help}", -1)
    end
    
  end # class OptionError
  
  # Raised when something goas wrong with command arguments
  class CommandArgumentError < Error

    # Wrong arguments
    attr_reader :args
    
    # Creates an error with wrong arguments
    def initialize(args)
      @args = args
    end
    
    # Default behavior is to print cause's message
    # and reraise a Help
    def react!
      raise Exit.new("Wrong arguments: #{args.join(' ')}\n#{command.help}", -1)
    end
    
  end
  
  # Raised when a command cannot be found
  class NoSuchCommandError < Error 
    
    # Default behavior is to reraise a Help(-1)
    def react!
      $stderr.puts self.message
      raise Help.new(-1)
    end
    
  end # class NoSuchCommandError
  
end # module Quickl