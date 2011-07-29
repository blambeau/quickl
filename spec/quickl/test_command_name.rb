require "spec_helper"
describe "Quickl#command_name" do

  subject{ Quickl.command_name(cmd) }
  
  describe "on a command class" do
    let(:cmd){ MiniClient::Say::Hello }
    it{ should eq("hello") }
  end
  
  describe "on a command instance" do
    let(:cmd){ MiniClient::Say::Hello.new }
    it{ should eq("hello") }
  end
  
end
