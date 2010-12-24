module Quickl
  module Naming
    
    #
    # Converts a command name to a module name. Implements
    # the following conversions:
    #
    #   hello -> Hello
    #   hello-world -> HelloWorld
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
    def module2command(mod)
      case mod
        when Module
          name = RubyTools::class_unqualified_name(mod)
          name = name.gsub(/[A-Z]/){|x| "-#{x.downcase}"}[1..-1]
        when String
          name = mod.to_s
          name = name.gsub(/[A-Z]/){|x| "-#{x.downcase}"}[1..-1]
        when Symbol
          name = mod.to_s
          name = name.gsub(/[A-Z]/){|x| "-#{x.downcase}"}[1..-1]
          name.to_sym
        else
          raise ArgumentError, "Invalid module argument #{mod.class}"
      end
    end
    
  end # module Naming
end # module Quickl