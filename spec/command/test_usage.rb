require 'spec_helper'
module Quickl
  describe "Command::usage /" do
    
    it "should be installed from inline rdoc" do
      MiniClient::Say::Hello.usage.should == "mini-client say:hello"
      MiniClient::Say::Goodbye.usage.should == "mini-client say:goodbye"
    end
    
  end # Command::usage
end # module Quickl
