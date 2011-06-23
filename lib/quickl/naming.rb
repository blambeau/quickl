module Quickl
  module Naming
    
    #
    # Converts a command name to a module name. Implements
    # the following conversions:
    #
    #   hello -> Hello
    #   hello-world -> HelloWorld
    #
    # This method is part of Quickl's private interface even
    # if its effect are considered public.
    #
    def command2module(name)
      case name
        when String
          name.gsub(/^(.)|-(.)/){|x| x.upcase}.gsub(/-/,'')
        when Symbol
          command2module(name.to_s).to_sym
        else
          raise ArgumentError, "Invalid name argument #{name.class}"
      end
    end
    
    #
    # Converts a module name to a command name. Implements the 
    # following conversions:
    #
    #     Hello -> hello
    #     HelloWorld -> hello-world
    #
    # This method is part of Quickl's private interface even
    # if its effect are considered public.
    #
    def module2command(mod)
      case mod
        when Module
          module2command(RubyTools::class_unqualified_name(mod))
        when String
          mod.gsub(/[A-Z]/){|x| "-#{x.downcase}"}[1..-1]
        when Symbol
          module2command(mod.to_s).to_sym
        else
          raise ArgumentError, "Invalid module argument #{mod.class}"
      end
    end
    
  end # module Naming
end # module Quickl