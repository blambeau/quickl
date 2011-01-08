#
# MiniClient main command
#
class MiniClient < Quickl::Delegate(__FILE__, __LINE__)
    
  #
  # Print help
  #
  # SYNOPSIS
  #   #{MiniClient.command_name} help
  #
  # DESCRIPTION
  #   #{command_name} prints help
  #
  class Help < Quickl::Command(__FILE__, __LINE__)

    def run(*args)
      :help
    end
      
  end # class Help
  
  class Say < Quickl::Delegate(__FILE__, __LINE__)

    #
    # Say hello to the user whose name is requested on the standard input
    #
    # SYNOPSIS
    #   #{MiniClient.command_name} say:hello
    #
    # DESCRIPTION
    #   And an explanation here
    #   on multiple lines with replacement: #{command_name}
    #
    class Hello < Quickl::Command(__FILE__, __LINE__)
      
      def run(*args)
        :hello
      end
      
    end # class Hello

    #
    # Say goodbye to the currently connected user
    #
    # SYNOPSIS
    #   #{MiniClient.command_name} say:goodbye
    #
    class Goodbye < Quickl::Command(__FILE__, __LINE__)

      def run(*args)
        :goodbye
      end
      
    end # class Goodbye

  end # class Say
    
end # module MiniClient