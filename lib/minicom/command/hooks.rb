module Minicom
  module Command::Hooks
    
    # Executions to be made
    def executions
      @executions ||= []
    end
  
    # Registers a command execution block
    def execute(&block)
      executions << block
    end
  
    # Registers a command execution block
    def execute_and_exit(status = 0, &block)
      execute{ 
        block.call(@args) 
        raise Minicom::Exit.new(0)
      }
    end
    
  end # module Command::Hooks
end # module Minicom