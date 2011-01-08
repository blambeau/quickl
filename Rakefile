# -*- ruby -*-
require 'rubygems'
require "rake/testtask"
require "rspec/core/rake_task"
require "yard"
require "rake/gempackagetask"

task :default => :test
task :test    => [:spec, :examples]

# About yard documentation
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', 'examples/**/*.rb']
  t.options = ['--output-dir', 'doc/api', '-', "README.md", "CHANGELOG.md"]
end

desc "Lauches unit tests on examples"
Rake::TestTask.new(:examples) do |test|
  test.libs       = [ "lib" ]
  test.test_files = Dir["examples/**/*_test.rb"]
  test.verbose    =  true
end

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
	t.rspec_opts = %w[--color]
	t.verbose = false
end

desc "Create the .gem package"
$spec = Kernel.eval(File.read(File.expand_path('../quickl.gemspec', __FILE__)))
Rake::GemPackageTask.new($spec) do |pkg|
	pkg.need_tar = true
end


# vim: syntax=ruby
