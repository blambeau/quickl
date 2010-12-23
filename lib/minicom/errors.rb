module Minicom
  
  # Main class of all Minicom's errors
  class Error < StandardError; end
  
  # Raised when a command cannot be found
  class NoSuchCommandError < Error; end
  
  # Marker to tell that the command should exit
  class Exit < Error
    
    # Exit code
    attr_reader :exit_code
    
    # Creates an Exit instance
    def initialize(exit_code)
      @exit_code = exit_code
    end
    
  end # class Exit
  
end # module Minicom