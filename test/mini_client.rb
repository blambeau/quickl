module MiniClient
  class Commands < Minicom::Command(__FILE__, __LINE__)
    
    #
    # Print help 
    #
    # Usage: mini_client help
    #
    class Help < Minicom::Command(__FILE__, __LINE__)
    end # class Help
    
    class Say < Minicom::Command(__FILE__, __LINE__)

      #
      # Say hello to the user whose name is requested on the
      # standard input
      #
      # Usage: mini_client say:hello
      #
      class Hello < Minicom::Command(__FILE__, __LINE__)
      end # class Hello

      #
      # Say goodbye to the currently connected user
      #
      # Usage: mini_client say:goodbye
      #
      class Goodbye < Minicom::Command(__FILE__, __LINE__)
      end # class Goodbye

    end # class Say
    
  end # class Commands
end # module MiniClient