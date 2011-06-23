# Quickl

* http://github.com/blambeau/quickl

## Description

Quickl helps you create commandline programs as simply as:

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
    class SimpleCommand < Quickl::Command(__FILE__, __LINE__)
    
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
    
From simple command to complex delegator (_ala_ 'git [--version] [--help] COMMAND [cmd options] ARGS...'), Quickl provides (or aims at providing) the following features:

* Simple command creations via simple classes
* Delegator commands and categories via ruby namespaces and naming conventions
* Command help and documentation provided through _rdoc_
* Command options via standard OptionParser
* Error handling trought special blocks, assertions methods and dedicated Error classes
* Unit/spec testing of commands, as they are part of the software

## Install

    sudo gem install quickl

## Then?

Try this:

    # have a look at options
    quickl --help
  
    # generate a hello.rb single command
    quickl --layout=single --options=help,version hello > hello.rb
  
    # test your command
    ruby hello.rb --help
    ruby hello.rb --version
    ruby hello.rb bob
  
    # see what has been generated
    cat hello.rb
  
Additional examples (see examples folder):

* [hello world example](https://github.com/blambeau/quickl/blob/master/examples/hello)
* [delegator example](https://github.com/blambeau/quickl/blob/master/examples/delegator)

## Version policy

Until version 1.0.0, moditications of public interfaces increase the minor version, while other changes increase the tiny version. After version 1.0.0, same changes will affect major and minor versions, respectively.

    0.1.0 -> 0.1.1    # enhancements and private API changes
    0.1.0 -> 0.2.0    # broken API on public interfaces
    
Public interfaces are:

* Quickl::Command and Quickl::Delegator calls
* DSL methods used in "subclasses" built by Quickl::Command and Quickl::Delegator
* RDoc -> command line documentation recognizers (synopsis, overview, documentation, ...)
* Naming conventions (module <-> command conversions)
* Default reactions to errors (Quickl::Help, Quickl::Exit, ...)

Until version 1.0.0, to preserve your application from hurting changes you should require quickl as follows:

    gem 'quickl', '< 0.2.0'    # Assuming current version is 0.1.xx
    require 'quickl'
