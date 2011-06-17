require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::subcommands /" do
    
    it "should return installed commands in an array" do
      MiniClient.subcommands.should == [ 
        MiniClient::Help, 
        MiniClient::Say,
        MiniClient::Requester,
      ]
      MiniClient::Say.subcommands.should == [ 
        MiniClient::Say::Hello,
        MiniClient::Say::Goodbye,
      ]
    end
    
    it "should take care of the command_parent= in command builder" do
      MiniClient::Requester.subcommands.should == [
        MiniClient::Factored
      ]
    end

  end # Command::subcommand
end # module Quickl
