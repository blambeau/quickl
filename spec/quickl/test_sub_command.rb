require 'spec_helper'
describe "Quickl.sub_command(!)" do

  describe "non bang version" do
    subject{ Quickl.sub_command(cmd, name) }

    describe "on a command class with existing sub" do
      let(:cmd){ MiniClient }
      let(:name){ "say:hello" }
      it{ should eq(MiniClient::Say::Hello) }
    end
    
    describe "on a command instance with existing sub" do
      let(:cmd){ MiniClient.new }
      let(:name){ "say:hello" }
      it{ should eq(MiniClient::Say::Hello) }
    end
    
    describe "when no such existing sub" do
      let(:cmd){ MiniClient.new }
      let(:name){ "say:wouwouwou" }
      it{ should be_nil }
    end
  end

  describe "the bang version" do
    subject{ Quickl.sub_command!(cmd, name) }

    describe "on a command class with existing sub" do
      let(:cmd){ MiniClient }
      let(:name){ "say:hello" }
      it{ should eq(MiniClient::Say::Hello) }
    end
    
    describe "on a command instance with existing sub" do
      let(:cmd){ MiniClient.new }
      let(:name){ "say:hello" }
      it{ should eq(MiniClient::Say::Hello) }
    end
    
    describe "when no such existing sub" do
      let(:cmd){ MiniClient.new }
      let(:name){ "say:wouwouwou" }
      specify{ lambda{subject}.should raise_error(Quickl::NoSuchCommand) }
    end
  end
  
end
