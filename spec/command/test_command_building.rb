require 'spec_helper'
module Quickl
  describe "Command building /" do
    
    it "should execute callback methods" do
      MiniClient::Factored.run.should == :hello
    end
    
    it "should install hierarchy correctly when command_parent= is used" do
      MiniClient::Factored.super_command.should == MiniClient::Requester
      MiniClient::Requester.subcommands.should include(MiniClient::Factored)
      lambda{ MiniClient::Requester.new.has_command!("factored") }.should_not raise_error
    end
    
  end # Command::command_name
end # module Quickl
