require File.expand_path('../fixtures', __FILE__)
module Quickl
  describe "RubyTools#extract_file_rdoc /" do
  
    subject{ RubyTools::rdoc_file_paragraphs(File.expand_path('../fixtures.rb', __FILE__)) }
  
    it "should be as expected" do
      subject.should == ["This is a fixtures helper that matches documentation conventions.\n", 
                         "This is a second paragraph\nThat append on two lines\n", 
                         "WARNING:\n  This kind of indentation should not be interpreted as code\n", 
                         "  But this one yes\n"]
    end
  
  end
end