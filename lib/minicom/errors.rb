module Minicom
  
  # Main class of all Minicom's errors
  class Error < StandardError; end
  
  # Raised when a command cannot be found
  class NoSuchCommandError < Error; end
  
end # module Minicom