$hello_doc = <<EOF

Say hello to the user whose name is requested on the standard input

SYNOPSIS
  mini-client say:hello

DESCRIPTION
  And an explanation here
  on multiple lines with replacement: hello

EOF
require "spec_helper"
describe "Quickl#documentation" do

  subject{ Quickl.documentation(cmd) }
  
  describe "on a command class" do
    let(:cmd){ MiniClient::Say::Hello }
    it{ should eq($hello_doc) }
  end
  
  describe "on a command instance" do
    let(:cmd){ MiniClient::Say::Hello.new }
    it{ should eq($hello_doc) }
  end

  it "should be aliased as help" do
    Quickl.help(MiniClient::Say::Hello).should eq($hello_doc)
  end
  
end
