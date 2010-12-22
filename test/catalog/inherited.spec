require File.expand_path('../../spec_helper', __FILE__)
module Minicom
  describe "Catalog::inherited /" do
  
    it "should install commands accessor on subclass" do
      MiniClient::Commands.should respond_to(:commands)
    end
    
    it "should make catalogs non newable" do
      lambda{ MiniClient::Commands.new }.should raise_error
    end
    
  end # Catalog::inherited
end # module Minicom
