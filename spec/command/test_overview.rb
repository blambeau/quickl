require 'spec_helper'
module Quickl
  describe "Command::overview /" do
    
    it "should be installed from inline rdoc" do
      MiniClient::Help.overview.should == "Print help"
    end

  end # Command::overview
end # module Quickl
