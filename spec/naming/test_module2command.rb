require 'spec_helper'
module Quickl
  describe "Naming::module2command /" do
    include Naming
    
    it "should uncapitalize first char" do
      module2command("Say").should eq("say")
      module2command(:Say).should eq(:say)
    end

    it "should uncapitalize and introduce dashes" do
      module2command("SayHello").should eq("say-hello")
      module2command(:"SayHello").should eq(:"say-hello")
    end
    
    it "should support taking modules as argument" do
      module2command(Quickl::Command).should eq("command")
    end
    
  end # module Quickl
end # module Quickl
