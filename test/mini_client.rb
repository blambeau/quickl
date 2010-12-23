module MiniClient
  class Command < Quickl::Delegate(__FILE__, __LINE__)
    
    #
    # Print help 
    #
    # Usage: mini_client help
    #
    class Help < Quickl::Command(__FILE__, __LINE__)

        def run(*args)
          :help
        end
        
    end # class Help
    
    class Say < Quickl::Delegate(__FILE__, __LINE__)

      #
      # Say hello to the user whose name is requested on the
      # standard input
      #
      # Usage: mini_client say:hello
      #
      # And an explanation here
      # on multiple lines
      #
      class Hello < Quickl::Command(__FILE__, __LINE__)
        
        def run(*args)
          :hello
        end
        
      end # class Hello

      #
      # Say goodbye to the currently connected user
      #
      # Usage: mini_client say:goodbye
      #
      class Goodbye < Quickl::Command(__FILE__, __LINE__)

        def run(*args)
          :goodbye
        end
        
      end # class Goodbye

    end # class Say
    
  end # class Command
end # module MiniClient