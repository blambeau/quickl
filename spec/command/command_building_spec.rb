require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command building /" do
    
    it "should execute callback methods" do
      MiniClient::Factored.run.should == :hello
    end
    
  end # Command::command_name
end # module Quickl
