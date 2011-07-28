module Quickl
  
  #
  # Main class of all Quickl's errors.
  #
  # Quickl's errors normally occur only in the context of a command 
  # execution, command which can be obtained through the dedicated 
  # accessor.
  #
  # Each Quickl error comes bundled with a default reaction implemented 
  # by the _react!_ method. Unless you provide your own reaction via
  # dedicated Command's DSL methods (react_to, no_react_to, ...), this
  # reaction will be executed if the error is raised. Default reactions
  # are implemented so that the command fail gracefully for the ordinary 
  # commandline user.
  #
  class Error < StandardError
    
    # Quickl command under execution
    attr_accessor :command
    
    # Exit code
    attr_reader :exit_code
    
    # Creates an Exit instance
    def initialize(*args)
      super(args.find{|s| s.is_a?(String)} || "")
      @exit_code = args.find{|s| s.is_a?(Integer)} || nil
    end
    
    # Returns true if exit code is not nil
    def exit?
      !exit_code.nil?
    end
    
    # Returns $stdout or $stderr according to exit code.
    def error_io
      exit_code == -1 ? $stderr : $stdout
    end
    
    # Print error's message on IO returned by error_io and
    # make a call to Kernel.exit with required exit code.
    def do_kernel_exit
      error_io.puts self.message
      Kernel.exit(exit_code) if exit?
    end
    
  end # class Error
  
  #
  # This error can be raised to exit command execution with a message
  # and exit code. 
  #
  # Default exit code: 
  #   0
  # 
  # Default reaction: 
  #   Prints the error message (on $stdout if exit code is 0, on $stderr 
  #   otherwise) then invoke Kernel.exit with the exit code.
  #
  # Examples:
  #
  #   # Non-failure exit, for --version, --help, --copyright and the 
  #   # like
  #   raise Quickl::Exit, "a friendly message"
  #
  #   # Failure exit, because something failed
  #   raise Quickl::Exit.new(-1), "Something was wrong!"
  #
  class Exit < Error
    
    def initialize(*args)
      super(*(args + [ 0 ]))
    end
    
    def react!
      do_kernel_exit
    end
    
  end # class Exit
  
  # 
  # This error can be raised to print command's help and exit.
  #
  # Default exit code: 
  #   0
  #
  # Default reaction: 
  #   raise Exit.new(code), additional + "\n" + help, backtrace
  #
  # Examples:
  # 
  #   # Print command help on $stdout and exit with 0
  #   raise Quickl::Help
  #
  #   # Print command help on $stderr and exit with -1
  #   raise Quickl::Help.new(-1)
  # 
  #   # Print additional message before help
  #   raise Quickl::Help, "Hello user, below if the help!"
  #
  class Help < Error
    
    def initialize(*args)
      super(*(args + [ 0 ]))
    end
    
    def react!
      msg = if (self.message || "").empty?
        command.class.help
      else
        self.message.to_s + "\n" + command.class.help
      end
      raise Exit.new(self.exit_code), msg, backtrace
    end
    
  end # class Help
  
  #
  # This error can be raised to indicate that some command option
  # was misused. This error is automatically raised on occurence
  # of an OptionParser::ParseError when options are parsed.
  #
  # Default exit code:
  #   -1
  # 
  # Default reaction: 
  #   raise Help.new(code), message, backtrace
  #
  # Examples:
  #
  #   # Print message on $stderr and exit with -1
  #   raise Quickl::InvalidOption, "--no-clue option does not exists" 
  #
  class InvalidOption < Error
    
    def initialize(*args)
      super(*(args + [ -1 ]))
    end
    
    def react!
      raise Help.new(self.exit_code), self.message, backtrace
    end
    
  end # class InvalidOption
  
  #
  # This error can be raised to indicate that some command argument
  # was misused.
  #
  # Default exit code:
  #   -1
  # 
  # Default reaction: 
  #   raise Help.new(code), message, backtrace
  #
  # Examples:
  #
  #   # Print message on $stderr and exit with -1
  #   raise Quickl::InvalidArgument, "Missing command argument" 
  #
  class InvalidArgument < Error

    def initialize(*args)
      super(*(args + [ -1 ]))
    end
    
    def react!
      raise Help.new(self.exit_code), self.message, backtrace
    end
    
  end # class InvalidArgument
  
  # 
  # This error can be raised to indicate that a command has not been
  # found (typically by delegators).
  #
  # Default exit code:
  #   -1
  # 
  # Default reaction: 
  #   raise Help.new(code), message, backtrace
  #
  class NoSuchCommand < Error 
    
    def initialize(*args)
      super(*(args + [ -1 ]))
    end
    
    def react!
      raise Help.new(self.exit_code), self.message, backtrace
    end
    
  end # class NoSuchCommand
  
  #
  # This error can be raised to indicate that some file/dir 
  # access has failed.
  #
  # Default exit code:
  #   -1
  #
  # Default reaction:
  #   raise Exit.new(code), message, backtrace
  #
  class IOAccessError < Error

    def initialize(*args)
      super(*(args + [ -1 ]))
    end
    
    def react!
      raise Exit.new(self.exit_code), self.message, backtrace
    end
    
  end # class IOAccessError
  
end # module Quickl