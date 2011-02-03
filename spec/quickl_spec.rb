require File.expand_path('../spec_helper', __FILE__)
describe Quickl do
  
  it "should have a version number" do
    Quickl.const_defined?(:VERSION).should be_true
  end
  
end
