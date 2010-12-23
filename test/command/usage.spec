require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::usage /" do
    
    it "should be installed from inline rdoc" do
      MiniClient::Command::Say::Hello.usage.should == "Usage: mini_client say:hello"
      MiniClient::Command::Say::Goodbye.usage.should == "Usage: mini_client say:goodbye"
    end

  end # Command::usage
end # module Quickl
