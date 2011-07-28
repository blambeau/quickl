require 'spec_helper'
describe "Quickl.has_subcommand!" do
  
  specify "has_subcommand! on a command class" do
    Quickl.has_subcommand!(MiniClient, "help").should be_true
    Quickl.has_subcommand!(MiniClient::Say, "hello").should be_true
    Quickl.has_subcommand!(MiniClient, "say:hello").should be_true
    lambda{
      Quickl.has_subcommand!(MiniClient, "no-such-command")
    }.should raise_error(Quickl::NoSuchCommand)
  end
  
  specify "has_subcommand! on a command instance" do
    Quickl.has_subcommand!(MiniClient.new, "help").should be_true
    Quickl.has_subcommand!(MiniClient::Say.new, "hello").should be_true
    Quickl.has_subcommand!(MiniClient.new, "say:hello").should be_true
    lambda{
      Quickl.has_subcommand!(MiniClient.new, "no-such-command")
    }.should raise_error(Quickl::NoSuchCommand)
  end
  
end
