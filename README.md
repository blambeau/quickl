# Minicom

* http://github.com/blambeau/minicom

## DESCRIPTION:

Minicom helps you create commandline programs as simply as:

    #
    # Short description here
    #
    # SYNOPSIS
    #   Usage: ...
    #
    # OPTIONS:
    # #{sumarized_options}
    #
    # DESCRIPTION
    #   Long description here...
    #
    class SimpleCommand < Minicom::Command(__FILE__, __LINE__)
    
      # install options below
      options do |opt|
        # _opt_ is an OptionParser instance
      end
      
      # install the code to run the command
      def execute(args)
        # _args_ are non-option command line parameters
      end
    
    end
    
Running them as simply as:

    SimpleCommand.run(ARGV)
    
From simple command to complex delegate (_ala_ 'git [--version] [--help] COMMAND [cmd options] ARGS...'), Minicom provides (or aims at providing) the following features:

* Simple command creations via simple classes
* Delegate commands and categories via ruby namespaces and naming conventions
* Command help and documentation provided through _rdoc_
* Command options via standard OptionParser
* Error handling trought special blocks, assertions methods and dedicated Error classes
* Unit/spec testing of commands, as they are part of the software

## INSTALL:

    sudo gem install minicom

## THEN?

* [hello_world example](https://github.com/blambeau/minicom/blob/master/examples/hello_world)


## LICENSE:

    (The MIT License)

    Copyright (c) 2010 Bernard Lambeau <blambeau@gmail.com>

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    'Software'), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
