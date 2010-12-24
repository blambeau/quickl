$hello_doc = <<EOF

Say hello to the user whose name is requested on the standard input

SYNOPSIS
  mini-client say:hello

DESCRIPTION
  And an explanation here
  on multiple lines with replacement: hello

EOF

require File.expand_path('../../spec_helper', __FILE__)
module Quickl
  describe "Command::documentation /" do
    
    it "should be correctly installed" do
      MiniClient::Say::Hello.documentation.should == $hello_doc[0..-1]
    end

  end # Command::command
end # module Quickl
