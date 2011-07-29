require "spec_helper"
describe "Quickl#overview" do

  subject{ Quickl.overview(cmd) }
  
  describe "on a command class" do
    let(:cmd){ MiniClient::Help }
    it{ should eq("Print help") }
  end
  
  describe "on a command instance" do
    let(:cmd){ MiniClient::Help.new }
    it{ should eq("Print help") }
  end
  
end
