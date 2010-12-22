require File.expand_path('../../spec_helper', __FILE__)
module Minicom
  describe "Naming::command2module /" do
    include Naming
    
    it "should capitalize first char" do
      command2module("say").should == "Say"
      command2module(:say).should == :Say
    end

    it "should capitalize support dashes" do
      command2module("say-hello").should == "SayHello"
      command2module(:"say-hello").should == :SayHello
    end
    
  end # module Minicom
end # module Minicom