require File.expand_path('../../../spec_helper', __FILE__)
module Quickl
  module Command::Delegator
    describe "InstanceMethods#split_argv" do
      
      let(:cmd){ Object.new.extend(InstanceMethods) }
      subject{ cmd.send(:split_argv, argv) }
      
      describe "on an empty array" do
        let(:argv){ [] }
        it { should eql([[],[]]) }
      end
        
    end
  end
end