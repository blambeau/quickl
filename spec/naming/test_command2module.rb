require 'spec_helper'
module Quickl
  describe "Naming::command2module /" do
    include Naming
    
    it "should capitalize first char" do
      command2module("say").should eq("Say")
      command2module(:say).should eq(:Say)
    end

    it "should capitalize support dashes" do
      command2module("say-hello").should eq("SayHello")
      command2module(:"say-hello").should eq(:SayHello)
    end
    
  end # module Quickl
end # module Quickl
