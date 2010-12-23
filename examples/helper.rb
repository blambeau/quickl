begin 
  require 'minicom'
rescue LoadError
  $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
  require 'minicom'
end
