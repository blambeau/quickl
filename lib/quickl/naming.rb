module Quickl
  module Naming
    
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
    
    def module2command(mod)
      name = RubyTools::class_unqualified_name(mod)
      name.gsub(/[A-Z]/){|x| "-#{x.downcase}"}[1..-1]
    end
    
  end # module Naming
end # module Quickl