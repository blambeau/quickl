require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::requester /" do
    
    it "should return nil if invoked immediately" do
      MiniClient::Requester.run([]).should be_nil
    end
    
    it "should return delegator if ran from delegator" do
      x = MiniClient.run(["requester"])
      x.should_not be_nil
      x.should be_a(MiniClient)
    end
    
  end # Command::requester
end # module Quickl