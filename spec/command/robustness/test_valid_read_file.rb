require 'spec_helper'
module Quickl
  describe "Command::Robustness#valid_read_file!" do
    
    let(:r){ Object.new.extend(Command::Robustness) }
    
    describe "with default options" do
    
      it "should raise a Quickl::IOAccessError with a friendly message" do
        begin
          r.valid_read_file!("nosuchone.nosuchextension") 
          true.should == false
        rescue Quickl::IOAccessError => ex
          ex.message.should =~ /Not a file/ 
          ex.message.should =~ /nosuchone.nosuchextension/
        end
      end
      
    end # with default options
    
    describe "with specific error class" do

      it "should raise it with a default message" do
        begin
          r.valid_read_file!("nosuchone.nosuchextension", ArgumentError) 
          true.should == false
        rescue ArgumentError => ex
          ex.message.should =~ /Not a file/ 
          ex.message.should =~ /nosuchone.nosuchextension/
        end
      end

    end # with specific message

    describe "with specific message" do

      it "should raise a Quickl::IOAccessError with a specific message" do
        begin
          r.valid_read_file!("nosuchone.nosuchextension", nil, "specific") 
          true.should == false
        rescue Quickl::IOAccessError => ex
          ex.message.should == "specific"
        end
      end

    end # with specific message
    
    describe 'with specific message and error class' do

      it "should raise a Quickl::IOAccessError with a specific message" do
        begin
          r.valid_read_file!("nosuchone.nosuchextension", ArgumentError, "specific") 
          true.should == false
        rescue ArgumentError => ex
          ex.message.should == "specific"
        end
      end

    end
    
  end
end # module Quickl