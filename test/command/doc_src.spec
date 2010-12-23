$hello_doc = <<EOF

Say hello to the user whose name is requested on the
standard input

Usage: mini_client say:hello

And an explanation here
on multiple lines

EOF

require File.expand_path('../../spec_helper', __FILE__)
module Minicom
  describe "Command::doc_src /" do
    
    it "should be correctly installed" do
      MiniClient::Command::Say::Hello.doc_src.should == $hello_doc[0..-1]
    end

  end # Command::command
end # module Minicom
