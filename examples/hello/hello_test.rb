require 'test/unit'
require 'stringio'
begin 
  require 'quickl'
rescue LoadError
  $LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
  require 'quickl'
end
Kernel.load File.expand_path('../hello', __FILE__)

class HelloTest < Test::Unit::TestCase
    
  def assert_exits(match, exit_code)  
    yield
    assert_false true, "Expected to exit with #{match}, nothing raised"
  rescue Quickl::Exit => ex
    assert_equal ex.exit_code, exit_code
    assert ex.message =~ match
  end
  
  def run_command(*args)
    $stdout = StringIO.new
    Hello.no_react_to(Quickl::Exit)
    Hello.run args
    $stdout.string
  ensure
    $stdout = STDOUT
  end
  
  def test_normal_runs
    assert_equal "Hello world!\n",    run_command
    assert_equal "Hello blambeau!\n", run_command("blambeau")
  end
  
  def test_capitalize
    assert_equal "Hello World!\n",    run_command("--capitalize")
    assert_equal "Hello Blambeau!\n", run_command("--capitalize", "blambeau")
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
  
  def test_too_many_arguments
    assert_exits(/Wrong arguments/, -1){ 
      run_command('hello', 'too') 
    }
  end
  
end