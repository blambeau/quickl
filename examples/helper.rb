begin 
  require 'quickl'
rescue LoadError
  $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
  require 'quickl'
end
