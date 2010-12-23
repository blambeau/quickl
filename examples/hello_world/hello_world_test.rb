require 'test/unit'
require 'stringio'
begin 
  require 'minicom'
rescue LoadError
  $LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
  require 'minicom'
end
Kernel.load File.expand_path('../hello_world', __FILE__)

class HelloWorldTest < Test::Unit::TestCase
    
  def hello_run(*args)
    $stdout = StringIO.new
    HelloWorld.error_handler(nil){|cmd,ex|
      @last_exception = ex
    }
    HelloWorld.run args
    $stdout.string
  ensure
    $stdout = STDOUT
  end
  
  def test_normal_runs
    assert_equal "Hello world!\n",    hello_run
    assert_equal "Hello blambeau!\n", hello_run("blambeau")
  end
  
  def test_capitalize
    assert_equal "Hello World!\n",    hello_run("--capitalize")
    assert_equal "Hello Blambeau!\n", hello_run("--capitalize", "blambeau")
  end
  
  def test_too_many_arguments
    hello_run('hello', 'too')
    assert @last_exception.is_a?(OptionParser::NeedlessArgument)
  end
  
  def test_help_option
    assert hello_run("--help") =~ /DESCRIPTION/
    assert @last_exception.is_a?(Minicom::Exit)
  end

  def test_help_option_shows_options
    assert hello_run("--help") =~ /Show help/
    assert @last_exception.is_a?(Minicom::Exit)
  end
  
  def test_version_option
    assert hello_run("--version") =~ /(c)/
    assert @last_exception.is_a?(Minicom::Exit)
  end
  
end