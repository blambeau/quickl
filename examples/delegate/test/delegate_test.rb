require 'test/unit'
require 'stringio'
begin 
  require 'quickl'
rescue LoadError
  $LOAD_PATH.unshift File.expand_path('../../../../lib', __FILE__)
  require 'quickl'
end
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'delegate'

class DelegateTest < Test::Unit::TestCase

  def delegate_run(*args)
    $stdout = StringIO.new
    Delegate.run args
    $stdout.string
  ensure
    $stdout = STDOUT
  end
  
  def test_alone
    #assert delegate_run =~ /Delegate execution to a sub command/
  end
  
  def test_help_delegation
    assert delegate_run("help", "hello-world") =~ /Say hello/
  end
  
  def test_hello_delegation
    assert_equal "Hello world!\n", delegate_run("hello-world")
    assert_equal "Hello bob!\n", delegate_run("hello-world", "bob")
  end
  
  def test_hello_capitalize
    assert_equal "Hello World!\n", delegate_run("hello-world", "--capitalize")
    assert_equal "Hello Bob!\n", delegate_run("hello-world", "bob", "--capitalize")
  end
  
end

