require 'spec_helper'
module Quickl
  describe "Naming::module2command /" do
    include Naming
    
    it "should uncapitalize first char" do
      module2command("Say").should == "say"
      module2command(:Say).should == :say
    end

    it "should uncapitalize and introduce dashes" do
      module2command("SayHello").should == "say-hello"
      module2command(:"SayHello").should == :"say-hello"
    end
    
    it "should support taking modules as argument" do
      module2command(Quickl::Command).should == "command"
    end
    
  end # module Quickl
end # module Quickl