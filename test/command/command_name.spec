require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::command_name /" do
    
    it "should be installed from inline rdoc" do
      MiniClient::Say::Hello.command_name.should == "hello"
      MiniClient::Say::Goodbye.command_name.should == "goodbye"
    end
    
    it "should be accessible on instance" do
      MiniClient::Say::Hello.new.command_name.should == "hello"
      MiniClient::Say::Goodbye.new.command_name.should == "goodbye"
    end

  end # Command::command_name
end # module Quickl
