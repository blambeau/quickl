require File.expand_path('../../spec_helper', __FILE__)
module Minicom
  describe "Command::run /" do
    
    it "when invoked on a terminal command" do
      MiniClient::Command::Say::Hello.run.should == :hello
      MiniClient::Command::Say::Goodbye.run.should == :goodbye
    end

    it "when invoked on a delegate command" do
      MiniClient::Command.run(["help"]).should == :help
      MiniClient::Command::Say.run(["hello"]).should == :hello
      MiniClient::Command::Say.run(["goodbye"]).should == :goodbye
    end

    it "when invoked on qualified command names" do
      MiniClient::Command.run(["say:hello"]).should == :hello
      MiniClient::Command.run(["say:goodbye"]).should == :goodbye
    end

  end # Command::command
end # module Minicom
