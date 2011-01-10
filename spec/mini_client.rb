#
# MiniClient main command
#
class MiniClient < Quickl::Delegator(__FILE__, __LINE__)
    
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

    def execute(*args)
      :help
    end
      
  end # class Help
  
  class Say < Quickl::Delegator(__FILE__, __LINE__)

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
      
      def execute(*args)
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

      def execute(*args)
        :goodbye
      end
      
    end # class Goodbye

  end # class Say
    
  #
  # Returns the requester object
  #
  # SYNOPSIS
  #   #{MiniClient.command_name} say:requester
  #
  class Requester < Quickl::Command(__FILE__, __LINE__)

    def execute(*args)
      requester
    end
    
  end # class Requester

end # module MiniClient