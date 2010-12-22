# -*- ruby -*-
$here = File.dirname(__FILE__)
require 'rubygems'
require 'hoe'
require 'spec/rake/spectask'

desc "Run all rspec test"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.ruby_opts = ['-I.', '-Ilib', '-Itest']
  t.spec_files = Dir["#{$here}/test/**/*.spec"]
end

# Hoe specification
Hoe.spec 'minicom' do
  self.developer('Bernard Lambeau', 'blambeau@gmail.com')
  self.readme_file      = 'README.md'
  self.extra_rdoc_files = FileList['README.md']
  self.extra_dev_deps << [ 'hoe', '>= 2.8.0' ]
end

# vim: syntax=ruby
