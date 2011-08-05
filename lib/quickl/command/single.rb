module Quickl
  
  # Instance method for being a single command
  module Command::Single
    
    # Run the command by delegation
    def run(argv = [], requester = nil)
      @requester = requester
      execute(parse_options(argv))
    end
    
  end # module Command::Single
  
  #
  # Create a single command
  #
  def self.Command(*args)
    command_builder do |b|
      b.document(*args) unless args.empty?
      b.instance_module(Command::Single)
      yield(b) if block_given?
    end
    Command
  end
  
end # module Quickl
