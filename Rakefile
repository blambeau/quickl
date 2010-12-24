# -*- ruby -*-
$here = File.dirname(__FILE__)
require 'rubygems'
require "rake/testtask"
require 'spec/rake/spectask'
require "yard"

task :default => :test
task :test    => [:spec, :examples]

# About yard documentation
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', 'examples/**/*.rb']
  t.options = ['--output-dir', 'doc/api', '-', "README.md", "HISTORY.md"]
end

desc "Lauches unit tests on examples"
Rake::TestTask.new(:examples) do |test|
  test.libs       = [ "lib" ]
  test.test_files = Dir["examples/**/*_test.rb"]
  test.verbose    =  true
end

desc "Run all rspec test"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.ruby_opts = ['-I.', '-Ilib', '-Itest']
  t.spec_files = Dir["#{$here}/test/**/*.spec"]
end

# vim: syntax=ruby
