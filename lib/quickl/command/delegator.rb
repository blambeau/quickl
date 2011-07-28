module Quickl
  module Command::Delegator
    module InstanceMethods
     
      # Run the command by delegation
      def run(argv = [], requester = nil)
        @requester = requester
        
        # My own options
        my_argv = []
        while argv.first =~ /^--/
          my_argv << argv.shift
        end
        parse_options(my_argv)
        
        execute(argv)
      rescue Quickl::Error => ex
        handle_error(ex)
      end
      
      def execute(argv)
        if cmd = argv.shift
          cmd = has_command!(cmd).run(argv, self)
        else
          raise Quickl::Help.new(cmd.nil? ? 0 : -1)
        end
      end
      
    end
    module ClassMethods
      
      def summarized_subcommands(subs = subcommands)
        doc = subs.collect{|cmd| 
          [cmd.command_name, cmd.overview]
        }
        max = doc.inject(0){|memo,pair| 
          l = pair.first.length
          memo > l ? memo : l
        }
        doc.collect{|pair|
          "  %-#{max}s     %s" % pair
        }.join("\n")
      end
      
    end
  end # module Command::Delegator
  
  #
  # Create a delegator command
  #
  def self.Delegator(*args)
    command_builder do |b|
      b.document *args
      b.class_module    Command::Delegator::ClassMethods
      b.instance_module Command::Delegator::InstanceMethods
      yield(b) if block_given?
    end
    Command
  end
  
  # @see Delegator
  def self.Delegate(*args, &block)
    self.Delegator(*args, &block)
  end
  
end # module Quickl