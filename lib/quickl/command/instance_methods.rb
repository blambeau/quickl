require 'optparse'
module Quickl
  class Command
    module InstanceMethods
      
      # Who is requesting command execution?
      attr_reader :requester
      
      # Delegate unrecognized calls to the command class
      # (gives access to options, help, usage, ...)
      def method_missing(name, *args, &block)
        if self.class.respond_to?(name)
          Quickl.deprecated(name, "self.class.#{name}", caller)
          self.class.send(name, *args, &block)
        else
          super
        end
      end

    end # module InstanceMethods
  end # class Command
end # module Quickl

