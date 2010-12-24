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

# PACKAGING & INSTALLATION ####################################################
# Largely inspired from the Citrus project

if defined?(Gem)
  $spec = eval("#{File.read('quickl.gemspec')}")

  directory 'dist'

  def package(ext='')
    "dist/#{$spec.name}-#{$spec.version}" + ext
  end

  file package('.gem') => %w< dist > + $spec.files do |f|
    sh "gem build quickl.gemspec"
    mv File.basename(f.name), f.name
  end

  file package('.tar.gz') => %w< dist > + $spec.files do |f|
    sh "git archive --format=tar HEAD | gzip > #{f.name}"
  end

  desc "Build packages"
  task :package => %w< .gem .tar.gz >.map {|e| package(e) }

  desc "Build and install as local gem"
  task :install => package('.gem') do |t|
    sh "gem install #{package('.gem')}"
  end

  desc "Upload gem to rubygems.org"
  task :release => package('.gem') do |t|
    sh "gem push #{package('.gem')}"
  end
end
# vim: syntax=ruby
