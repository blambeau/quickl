require 'spec_helper'
describe "Quickl.super_command" do

  subject{ Quickl.super_command(cmd) }
  
  describe "on a command class" do
    let(:cmd){ MiniClient::Say::Hello }
    it{ should eq(MiniClient::Say) }
  end
  
  describe "on a command instance" do
    let(:cmd){ MiniClient::Say::Hello.new }
    it{ should eq(MiniClient::Say) }
  end
  
end
