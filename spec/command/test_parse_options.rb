require 'spec_helper'
describe "Command#parse_options" do

  let(:cmd){ MiniClient::Say::Args.new }
  subject{ cmd.parse_options(argv, sep_support) }

  describe "when no separator support" do
    let(:sep_support){ :none }
    
    describe "on empty array" do
      let(:argv){ [] }
      it { should eq([]) }
    end

    describe "without any option nor separator" do
      let(:argv){ ["hello", "world"] }
      it { should eq(argv) }
    end

    describe "with disseminated options" do
      let(:argv){ %w{-i hello --joption -k world} }
      it { should eq(%w{hello world}) }
    end

    describe "with an option separator" do
      let(:argv){ %w{-i hello -- --joption -k world} }
      it { should eq(%w{hello --joption -k world}) }
    end

  end

  describe "when separator support set to :keep" do
    let(:sep_support){ :keep }
    
    describe "on empty array" do
      let(:argv){ [] }
      it { should eq([]) }
    end

    describe "without any option nor separator" do
      let(:argv){ ["hello", "world"] }
      it { should eq(argv) }
    end

    describe "with disseminated options" do
      let(:argv){ %w{-i hello --joption -k world} }
      it { should eq(%w{hello world}) }
    end

    describe "with an option separator" do
      let(:argv){ %w{-i hello -- --joption -k world} }
      it { should eq(%w{hello -- --joption -k world}) }
    end

    describe "with an option separator at first" do
      let(:argv){ %w{-- -i hello -- --joption -k world} }
      it { should eq(%w{-- -i hello -- --joption -k world}) }
    end

    describe "with an option separator at last" do
      let(:argv){ %w{-i hello --joption -k world --} }
      it { should eq(%w{hello world --}) }
    end

    describe "with multiple option separators" do
      let(:argv){ %w{-i hello -- --joption -k -- world --} }
      it { should eq(%w{hello -- --joption -k -- world --}) }
    end

  end

  describe "when separator support set to :split" do
    let(:sep_support){ :split }
    
    describe "on empty array" do
      let(:argv){ [] }
      it { should eq([[]]) }
    end

    describe "without any option nor separator" do
      let(:argv){ ["hello", "world"] }
      it { should eq([argv]) }
    end

    describe "with disseminated options" do
      let(:argv){ %w{-i hello --joption -k world} }
      it { should eq([%w{hello world}]) }
    end

    describe "with an option separator" do
      let(:argv){ %w{-i hello -- --joption -k world} }
      it { should eq([%w{hello},%w{--joption -k world}]) }
    end

    describe "with an option separator at first" do
      let(:argv){ %w{-- -i hello -- --joption -k world} }
      it { should eq([%w{}, %w{-i hello}, %w{--joption -k world}]) }
    end

    describe "with an option separator at last" do
      let(:argv){ %w{-i hello --joption -k world --} }
      it { should eq([%w{hello world},%w{}]) }
    end

    describe "with multiple option separators" do
      let(:argv){ %w{-i hello -- --joption -k -- world --} }
      it { should eq([%w{hello}, %w{--joption -k}, %w{world}, %w{}]) }
    end

  end

end
