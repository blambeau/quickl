require 'test/unit'
require 'stringio'
begin 
  require 'quickl'
rescue LoadError
  $LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
  require 'quickl'
end
Kernel.load File.expand_path('../hello_world', __FILE__)

class HelloWorldTest < Test::Unit::TestCase
    
  def hello_run(*args)
    $stdout = StringIO.new
    $stderr = StringIO.new
    begin
      HelloWorld.run args
    rescue Quickl::Error
    end
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
  
  # def test_help_option
  #   HelloWorld.run("--help") =~ /DESCRIPTION/
  #   assert @last_exception.is_a?(Quickl::Exit)
  # end
  
  # def test_too_many_arguments
  #   hello_run('hello', 'too')
  #   assert @last_exception.is_a?(OptionParser::NeedlessArgument)
  # end
  # 
  # def test_help_option_shows_options
  #   assert hello_run("--help") =~ /Show help/
  #   assert @last_exception.is_a?(Quickl::Exit)
  # end
  # 
  # def test_version_option
  #   assert hello_run("--version") =~ /(c)/
  #   assert @last_exception.is_a?(Quickl::Exit)
  # end
  
end