require 'spec_helper'
module Quickl
  describe "Command::run /" do
    
    specify "when invoked on a terminal command" do
      MiniClient::Say::Hello.run.should eql(:hello)
      MiniClient::Say::Goodbye.run.should eql(:goodbye)
    end

    specify "when invoked on a delegator command" do
      MiniClient.run(["help"]).should eql(:help)
      MiniClient::Say.run(["hello"]).should eql(:hello)
      MiniClient::Say.run(["goodbye"]).should eql(:goodbye)
    end

    specify "when invoked on qualified command names" do
      MiniClient.run(["say:hello"]).should eql(:hello)
      MiniClient.run(["say:goodbye"]).should eql(:goodbye)
    end
    
    specify "when --options are passed to a delegator command" do
      mini = MiniClient.new
      mini.run(%w{--verbose say:hello}).should eql(:hello)
      mini.verbose.should be_true
    end
    
    specify "when -option is passed to a delegator command" do
      mini = MiniClient.new
      mini.run(%w{-v say:hello}).should eql(:hello)
      mini.verbose.should be_true
    end
    
    specify "when --no-option is passed to a delegator command" do
      mini = MiniClient.new
      mini.run(%w{--no-verbose say:hello}).should eql(:hello)
      mini.verbose.should be_false
    end

    specify "when option separators are used and no special support" do
      mini = MiniClient::Say::Args.new 
      mini.run(%w{hello -- world}).should eql(%w{hello world})
    end 
    
    specify "when option separators are used and special support" do
      mini = MiniClient::Say::Args.new 
      mini.run(%w{hello -- world}, true).should eql([%w{hello},%w{world}])
    end 
    
  end # Command::command
end # module Quickl
