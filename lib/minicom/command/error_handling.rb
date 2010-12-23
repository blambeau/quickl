module Minicom
  module Command::ErrorHandling
    
    # Adds an error handler
    def error_handler(filter = nil, &block)
      @error_handlers ||= []
      @error_handlers.unshift [filter, block]
    end
    
    # Builds default error handlers
    def default_error_handlers
      error_handler(Minicom::Exit){|cmd, e|
        exit(e.exit_code)
      }
      error_handler(Interrupt){|cmd, e|
        $stderr.puts "Interrupted"
        exit(-1)
      }
      error_handler(OptionParser::ParseError){|cmd, e|
        $stderr.puts e.message
        $stderr.puts cmd.usage
        exit(-1)
      }
    end
    
    # Handles an error that occured
    def handle_error(e)
      raise e unless @error_handlers
      h = @error_handlers.find{|handler|
        handler.first.nil? or e.is_a?(handler.first)
      }
      raise e unless h
      h.last.call(self, e)
    end
    
  end # module Command::ErrorHandling
end # module Minicom