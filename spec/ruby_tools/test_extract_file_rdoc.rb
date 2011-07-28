require File.expand_path('../fixtures', __FILE__)
module Quickl
  describe "RubyTools#extract_file_rdoc /" do
    
    let(:file){ File.expand_path('../fixtures.rb', __FILE__) }
    
    describe "when used without line and reverse options" do

      subject{ RubyTools::extract_file_rdoc(file) }
  
      it "should be as expected" do
        subject.should == File.read(File.expand_path('../fixtures/RubyTools.rdoc', __FILE__))
      end

    end
    
    describe "when used with line and reverse options" do

      subject{ RubyTools::extract_file_rdoc(file, 23, true) }
  
      it "should be as expected" do
        subject.should == File.read(File.expand_path('../fixtures/Utils.rdoc', __FILE__))
      end

    end
  
  end # RubyTools#extract_file_rdoc
end # module Quickl