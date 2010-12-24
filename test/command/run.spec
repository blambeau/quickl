require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::run /" do
    
    it "when invoked on a terminal command" do
      MiniClient::Say::Hello.run.should == :hello
      MiniClient::Say::Goodbye.run.should == :goodbye
    end

    it "when invoked on a delegate command" do
      MiniClient.run(["help"]).should == :help
      MiniClient::Say.run(["hello"]).should == :hello
      MiniClient::Say.run(["goodbye"]).should == :goodbye
    end

    it "when invoked on qualified command names" do
      MiniClient.run(["say:hello"]).should == :hello
      MiniClient.run(["say:goodbye"]).should == :goodbye
    end

  end # Command::command
end # module Quickl
