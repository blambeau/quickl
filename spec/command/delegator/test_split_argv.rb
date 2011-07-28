require 'spec_helper'
module Quickl
  module Command::Delegator
    describe "InstanceMethods#split_argv" do
      
      let(:cmd){ Object.new.extend(InstanceMethods) }
      subject{ cmd.send(:split_argv, argv) }
      
      describe "on an empty array" do
        let(:argv){ [] }
        it { should eql([[],[]]) }
      end
      
      describe "on an array without options" do
        let(:argv){ ["hello", "world"] }
        it { should eql([[],["hello", "world"]]) }
      end
        
      describe "on an array with one single double dashed options" do
        let(:argv){ ["--verbose", "hello", "--world"] }
        it { should eql([["--verbose"],["hello", "--world"]]) }
      end
        
      describe "on an array with one single dashed options" do
        let(:argv){ ["-Ilib", "hello", "--world"] }
        it { should eql([["-Ilib"],["hello", "--world"]]) }
      end
        
      describe "on an array with multiple options" do
        let(:argv){ ["--verbose", "-Ilib", "hello", "--world"] }
        it { should eql([["--verbose","-Ilib"],["hello", "--world"]]) }
      end
        
      describe "in presence of an argument separator" do
        let(:argv){ ["--verbose", "-Ilib", "--", "-b", "hello", "--world"] }
        it { should eql([["--verbose","-Ilib"],["--", "-b", "hello", "--world"]]) }
      end

    end
  end
end