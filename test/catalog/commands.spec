require File.expand_path('../../spec_helper', __FILE__)
module Minicom
  describe "Catalog::command /" do
    
    it "should return installed commands in an array" do
      MiniClient::Commands.commands.should == [ MiniClient::Commands::Help ]
    end
    
    it "should return installed commands in an array" do
      MiniClient::Commands::Say.commands.should == [ 
        MiniClient::Commands::Say::Hello,
        MiniClient::Commands::Say::Goodbye
      ]
    end

  end # Catalog::command
end # module Minicom
