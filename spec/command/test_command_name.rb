require 'spec_helper'
module Quickl
  describe "Command::command_name /" do
    
    it "should be installed from inline rdoc" do
      MiniClient::Say::Hello.command_name.should == "hello"
      MiniClient::Say::Goodbye.command_name.should == "goodbye"
    end
    
  end # Command::command_name
end # module Quickl
