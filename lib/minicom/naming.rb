module Minicom
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
    
  end # module Naming
end # module Minicom