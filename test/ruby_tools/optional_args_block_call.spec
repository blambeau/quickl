require File.expand_path('../fixtures', __FILE__)
module Minicom
  describe "RubyTools#optional_args_block_call /" do
  
    subject{ RubyTools::optional_args_block_call(block, args) }
  
    describe "when block has no arguments /" do
      let(:block){ lambda {
        "ok"
      } }

      describe "when no args are given" do
        let(:args){ [ ] } 
        it { should == "ok" }
      end

      describe "when no args are given" do
        let(:args){ [ "hello" ] } 
        it { should == "ok" }
      end

    end
  
    describe "when block has one arguments /" do
      let(:block){ lambda {|name|
        name
      } }

      describe "when args are given" do
        let(:args){ [ "hello" ] } 
        it { should == "hello" }
      end

    end
  
  end
end