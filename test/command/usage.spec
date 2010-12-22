require File.expand_path('../../spec_helper', __FILE__)
module Minicom
  describe "Command::usage /" do
    
    it "should be installed from inline rdoc" do
      MiniClient::Commands::Say::Hello.usage.should == "Usage: mini_client say:hello"
      MiniClient::Commands::Say::Goodbye.usage.should == "Usage: mini_client say:goodbye"
    end

  end # Catalog::command
end # module Minicom
