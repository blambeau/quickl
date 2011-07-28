require 'spec_helper'
describe Quickl do
  
  it "should have a version number" do
    Quickl.const_defined?(:VERSION).should be_true
  end
  
end
