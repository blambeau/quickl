$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'quickl'

Gem::Specification.new do |s|
  s.name = 'quickl'
  s.version = Quickl::VERSION
  s.date = Time.now.strftime('%Y-%m-%d')

  s.summary = 'Generate Ruby command line apps quickly'
  s.description = 'Generate Ruby command line apps quickly'

  s.author = 'Bernard Lambeau'
  s.email = 'blambeau@gmail.com'

  s.require_paths = %w{ lib }

  s.files = 
    Dir['lib/**'] +
    Dir['examples/**'] +
    Dir['templates/**'] +
    Dir['bin/**'] +
    Dir['test/**'] +
    %w{ quickl.gemspec Rakefile README.md CHANGELOG.md }

  s.test_files = s.files.select {|path| path =~ /^test\/.*_test.rb/ }

  s.add_development_dependency('rake')

  s.has_rdoc = true
  s.rdoc_options = %w< --line-numbers --inline-source --title Quickl --main Quickl >
  s.extra_rdoc_files = %w< README.md >

  s.homepage = 'http://github.com/blambeau/quickl'
end
