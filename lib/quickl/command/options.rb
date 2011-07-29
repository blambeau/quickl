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
      
      #
      # Parses options in `argv` with an OptionParser instance and returns 
      # non-options arguments.
      #
      # The following example illustrates the role of `sep_support`
      #
      #     parse_options %w{--verbose hello -- quickl --say and world}
      #     # => ["hello", "quickl", "--say", "and", "world"]
      #
      #     parse_options %w{--verbose hello -- quickl --say and world}, :keep
      #     # => ["hello", "--", "quickl", "--say", "and", "world"]
      #
      #     parse_options %w{--verbose hello -- quickl --say and world}, :split
      #     # => [["hello"], ["quickl", "--say", and", "world"]]
      #
      def parse_options(argv, sep_support = :none)
        case sep_support
        when NilClass, :none
          options.parse!(argv)
        when :split, :keep
          parts = Quickl.split_commandline_args(argv)
          parts[0] = options.parse!(parts[0])
          if sep_support == :keep
            parts.inject(nil){|memo,arr| memo ? memo + ["--"] + arr : arr.dup}
          else
            parts
          end
        end
      rescue OptionParser::ParseError => ex
        raise Quickl::InvalidOption, ex.message, ex.backtrace
      end
      
    end # module InstanceMethods
  end # module Command::Options
end # module Quickl
