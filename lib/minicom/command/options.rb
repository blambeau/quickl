module Minicom
  module Command::Options
    module ClassMethods
      
      # Installed options builders
      attr_reader :option_builders
    
      # Adds an option builder
      def option_builder(builder = nil, &block)
        @option_builders ||= []
        @option_builders << (builder || block)
      end
    
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
      alias :options :build_options
      
      # Returns summarized options
      def summarized_options
        options.summarize.join.rstrip
      end
      
      # Installs options for --help and --version
      def help_and_version(version)
        lambda{|opt|
          # Show the help and exit
          opt.on_tail("--help", "Show help") do
            puts_and_exit usage + "\n" + summarized_options
          end

          # Show version and exit
          opt.on_tail("--version", "Show version") do
            puts_and_exit "#{opt.program_name} #{version}"
          end
        }
      end
      
    end # module ClassMethods
    module InstanceMethods
      
      # Returns OptionParser instance
      def options
        @options ||= self.class.build_options(self)
      end
      
    end # module InstanceMethods
  end # module Command::Options
end # module Minicom