require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::subcommands /" do
    
    it "should return installed commands in an array" do
      MiniClient::Command.subcommands.should == [ 
        MiniClient::Command::Help, 
        MiniClient::Command::Say 
      ]
    end
    
    it "should return installed commands in an array" do
      MiniClient::Command::Say.subcommands.should == [ 
        MiniClient::Command::Say::Hello,
        MiniClient::Command::Say::Goodbye
      ]
    end

  end # Command::subcommand
end # module Quickl
