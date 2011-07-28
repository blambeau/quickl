require 'spec_helper'
describe Quickl do
  
  it "should have a version number" do
    Quickl.const_defined?(:VERSION).should be_true
  end
  
  specify "has_subcommand!" do
    Quickl.has_subcommand!(MiniClient, "help").should be_true
    Quickl.has_subcommand!(MiniClient::Say, "hello").should be_true
    Quickl.has_subcommand!(MiniClient, "say:hello").should be_true
    lambda{
      Quickl.has_subcommand!(MiniClient, "no-such-command")
    }.should raise_error(Quickl::NoSuchCommand)
  end
  
end
