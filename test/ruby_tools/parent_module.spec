require File.expand_path('../fixtures', __FILE__)
module Minicom
  describe "RubyTools#parent_module /" do
  
    subject{ RubyTools::parent_module(clazz) }
  
    describe "when called on unqualified class" do
      let(:clazz){ ::String }
      it{ should be_nil }
    end
  
    describe "when called on qualified class" do
      let(:clazz){ RubyTools }
      it{ should == Minicom }
    end
  
    describe "when called on long qualified class" do
      let(:clazz){ Minicom::Fixtures::Utils }
      it{ should == Minicom::Fixtures }
    end
  
  end
end