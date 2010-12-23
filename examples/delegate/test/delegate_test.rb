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

  def assert_exits(match, exit_code)  
    yield
    assert_false true, "Expected to exit with #{match}, nothing raised"
  rescue Quickl::Exit => ex
    assert_equal ex.exit_code, exit_code
    assert ex.message =~ match
  end
  
  def run_command(*args)
    $stdout = StringIO.new
    Delegate.no_react_to(Quickl::Exit)
    Delegate.run args
    $stdout.string
  ensure
    $stdout = STDOUT
  end
  
  def test_alone
    assert_exits(/Delegate execution to a sub command/, 0){ run_command }
  end
  
  def test_help_option
    assert_exits(/DESCRIPTION/, 0){ 
      run_command("--help") 
    }
  end
  
  def test_version_option
    assert_exits(/(c)/, 0){ 
      run_command("--version") 
    }
  end
  
  def test_no_such_option
    assert_exits(/invalid option/, -1){ 
      run_command("--no-such-option") 
    }
  end
  
  def test_help_delegation
    assert run_command("help", "hello-world") =~ /Say hello/
  end
  
  def test_hello_delegation
    assert_equal "Hello world!\n", run_command("hello-world")
    assert_equal "Hello bob!\n", run_command("hello-world", "bob")
  end
  
  def test_hello_capitalize
    assert_equal "Hello World!\n", run_command("hello-world", "--capitalize")
    assert_equal "Hello Bob!\n", run_command("hello-world", "bob", "--capitalize")
  end
  
end

