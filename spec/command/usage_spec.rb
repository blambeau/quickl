require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::usage /" do
    
    it "should be installed from inline rdoc" do
      MiniClient::Say::Hello.usage.should == "mini-client say:hello"
      MiniClient::Say::Goodbye.usage.should == "mini-client say:goodbye"
    end
    
    it "should be accessible on instance" do
      MiniClient::Say::Hello.new.usage.should == "mini-client say:hello"
      MiniClient::Say::Goodbye.new.usage.should == "mini-client say:goodbye"
    end

  end # Command::usage
end # module Quickl
