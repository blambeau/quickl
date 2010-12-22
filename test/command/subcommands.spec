require File.expand_path('../../spec_helper', __FILE__)
module Minicom
  describe "Command::subcommands /" do
    
    it "should return installed commands in an array" do
      MiniClient::Commands.subcommands.should == [ 
        MiniClient::Commands::Help, 
        MiniClient::Commands::Say 
      ]
    end
    
    it "should return installed commands in an array" do
      MiniClient::Commands::Say.subcommands.should == [ 
        MiniClient::Commands::Say::Hello,
        MiniClient::Commands::Say::Goodbye
      ]
    end

  end # Command::subcommand
end # module Minicom
