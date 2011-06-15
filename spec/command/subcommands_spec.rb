require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::subcommands /" do
    
    it "should return installed commands in an array" do
      MiniClient.subcommands.should == [ 
        MiniClient::Help, 
        MiniClient::Say,
        MiniClient::Requester,
        MiniClient::Factored
      ]
    end
    
    it "should return installed commands in an array" do
      MiniClient::Say.subcommands.should == [ 
        MiniClient::Say::Hello,
        MiniClient::Say::Goodbye,
      ]
    end

  end # Command::subcommand
end # module Quickl
