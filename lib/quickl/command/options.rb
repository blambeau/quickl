module Quickl
  module Command::Options
    module ClassMethods
      
      # Installed options builders
      attr_reader :option_builders
    
      # Builds an OptionParser instance
      def build_options(scope = self)
        OptionParser.new do |opt|
          opt.program_name = File.basename $0
          if const_defined?(:VERSION)
            opt.version = const_get(:VERSION)
          end
          opt.summary_indent = ' ' * 2
          (option_builders || []).each{|b| 
            scope.instance_exec(opt, &b)
          }
        end
      end
      
      # Without builder nor block, returns built options.
      # Otherwise, adds a new option builder 
      def options(builder = nil, &block)
        if b = (builder || block)
          @option_builders ||= []
          @option_builders << b
        else
          build_options
        end
      end
      
      # Returns summarized options
      def summarized_options
        options.summarize.join.rstrip
      end
      
    end # module ClassMethods
    module InstanceMethods
      
      # Returns OptionParser instance
      def options
        @options ||= self.class.build_options(self)
      end
      
      # Parses options
      def parse_options(argv)
        options.parse!(argv)
      rescue OptionParser::ParseError => ex
        raise Quickl::InvalidOption, ex.message, ex.backtrace
      end
      
    end # module InstanceMethods
  end # module Command::Options
end # module Quickl