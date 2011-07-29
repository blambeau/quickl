require "spec_helper"
describe "Quickl#usage" do

  subject{ Quickl.usage(cmd) }
  
  describe "on a command class" do
    let(:cmd){ MiniClient::Say::Hello }
    it{ should eq("mini-client say:hello") }
  end
  
  describe "on a command instance" do
    let(:cmd){ MiniClient::Say::Hello.new }
    it{ should eq("mini-client say:hello") }
  end
  
end
