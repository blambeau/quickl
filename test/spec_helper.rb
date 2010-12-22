dir = File.dirname(__FILE__)
$LOAD_PATH.unshift "#{dir}/../lib"

require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'pp'
require 'fileutils'
require 'minicom'

Spec::Runner.configure do |config|
end
