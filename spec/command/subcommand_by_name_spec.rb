require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::subcommand_by_name /" do
    
    specify "when called on single command names" do
      MiniClient.subcommand_by_name("help").should == MiniClient::Help
      MiniClient.subcommand_by_name("noway").should be_nil
    end
    
    specify "when called on complex command names" do
      MiniClient.subcommand_by_name("say:hello").should == MiniClient::Say::Hello
    end
    
  end # Command::command_name
end # module Quickl
