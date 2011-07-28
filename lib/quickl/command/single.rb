module Quickl
  
  # Instance method for being a single command
  module Command::Single
    
    # Command arguments after options parsing
    attr_reader :args

    # Run the command by delegation
    def run(argv = [], requester = nil)
      @requester = requester
      execute(parse_options(argv))
    rescue Quickl::Error => ex
      handle_error(ex)
    end
    
  end # module Command::Single
  
  #
  # Create a single command
  #
  def self.Command(*args)
    command_builder do |b|
      b.document *args
      b.instance_module Command::Single
      yield(b) if block_given?
    end
    Command
  end
  
end # module Quickl