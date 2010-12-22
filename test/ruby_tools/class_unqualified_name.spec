require File.expand_path('../fixtures', __FILE__)
module Minicom
  describe "RubyTools#class_unqualified_name /" do
  
    subject{ RubyTools::class_unqualified_name(clazz) }
  
    describe "when called on unqualified class" do
      let(:clazz){ ::String }
      it{ should == "String" }
    end
  
    describe "when called on qualified class" do
      let(:clazz){ RubyTools }
      it{ should == "RubyTools" }
    end
  
    describe "when called on long qualified class" do
      let(:clazz){ Minicom::Fixtures::Utils }
      it{ should == "Utils" }
    end
  
    describe "when piped with parent_module" do
      let(:clazz){ RubyTools::parent_module(Minicom::Fixtures::Utils) }
      it{ should == "Fixtures" }
    end

  end
end
