module Quickl
  module Command::Delegator
    module InstanceMethods
     
      # Run the command by delegation
      def _run(argv = [])
        # My own options
        my_argv = []
        while argv.first =~ /^--/
          my_argv << argv.shift
        end
        parse_options(my_argv)
      
        # Run the subcommand now
        if cmd = argv.shift
          cmd = has_command!(cmd).run(argv, self)
        else
          raise Quickl::Help.new(cmd.nil? ? 0 : -1)
        end
      end
      
    end
    module ClassMethods
      
      def summarized_subcommands
        doc = subcommands.collect{|cmd| 
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
    end
    Command
  end
  
  # @see Delegator
  def self.Delegate(*args)
    self.Delegator(*args)
  end
  
end # module Quickl