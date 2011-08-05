require 'optparse'
module Quickl
  class Command
    module InstanceMethods
      
      # Who is requesting command execution?
      attr_reader :requester

    end # module InstanceMethods
  end # class Command
end # module Quickl

