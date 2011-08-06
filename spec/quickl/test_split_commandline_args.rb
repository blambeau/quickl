require 'spec_helper'
describe "Quickl.split_commandline_args" do

  subject{ Quickl.split_commandline_args(args) }

  describe "on an empty array" do
    let(:args){ %w{} }
    it { should eq([%w{}]) }
  end

  describe "without an option separator" do
    let(:args){ %w{hello world} }
    it { should eq([%w{hello world}]) }
  end

  describe "with an option at start" do
    let(:args){ %w{-- hello world} }
    it { should eq([%w{}, %w{hello world}]) }
  end

  describe "with an option at end" do
    let(:args){ %w{hello world --} }
    it { should eq([%w{hello world}, %w{}]) }
  end

  describe "with an option separator in the middle" do
    let(:args){ %w{hello -- world} }
    it { should eq([%w{hello}, %w{world}]) }
  end

  describe "on a complex example" do
    let(:args){ %w{-- hello -- hello2 hello3 -- x --} }
    let(:expected){[
      %w{}, %w{hello}, %w{hello2 hello3}, %w{x}, %w{}
    ]}
    it { should eq(expected) }
  end

  describe "with a specific separator" do
    subject{ Quickl.split_commandline_args(args, '|') }
    let(:args){ %w{hello | hello2 hello3 | x } }
    let(:expected){[
      %w{hello}, %w{hello2 hello3}, %w{x}
    ]}
    it { should eq(expected) }
  end

end
