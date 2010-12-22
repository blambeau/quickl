require File.expand_path('../../spec_helper', __FILE__)
module Minicom
  describe "Catalog::inherited /" do
  
    it "should install commands accessor on subclass" do
      MiniClient::Commands.should respond_to(:commands)
    end
    
  end # Catalog::inherited
end # module Minicom
