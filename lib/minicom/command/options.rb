module Minicom
  module Command::Options
    module ClassMethods
      
      # Installed options builders
      attr_reader :option_builders
    
      # Adds an option builder
      def option_builder(&block)
        @option_builders ||= []
        @option_builders << block
      end
    
      # Builds an OptionParser instance
      def build_options(scope = self)
        OptionParser.new do |opt|
          opt.program_name = File.basename $0
          if const_defined?(:VERSION)
            opt.version = const_get(:VERSION)
          end
          opt.summary_indent = ' ' * 2
          opt.banner = self.usage
          option_builders.each{|b| 
            scope.instance_exec(opt, &b)
          }
        end
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