require File.expand_path('../../spec_helper', __FILE__)
module Minicom
  describe "Command::run /" do
    
    it "when invoked on a terminal command" do
      MiniClient::Command::Say::Hello.run.should == :hello
      MiniClient::Command::Say::Goodbye.run.should == :goodbye
    end

    it "when invoked on a delegate command" do
      MiniClient::Command::Say.run(__FILE__, ["hello"]).should == :hello
      MiniClient::Command::Say.run(__FILE__, ["goodbye"]).should == :goodbye
    end

  end # Command::command
end # module Minicom
