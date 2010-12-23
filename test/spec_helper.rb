dir = File.dirname(__FILE__)
$LOAD_PATH.unshift "#{dir}/../lib"

require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'pp'
require 'fileutils'
require 'quickl'
require 'mini_client'

Spec::Runner.configure do |config|
end
