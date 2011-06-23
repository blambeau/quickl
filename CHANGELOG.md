# 0.2.2 / TODO

* Bug fixes

  * The gem is now shipped with the template/single.erb file. This fixes the 
    'quickl' commandline that generates skeletons as illustrated in README 
    (patch and thanks to Rit Li)
  * Broken links to the examples from the README are also fixed (Travis Briggs)

# 0.2.1 / 2011.06.19

* Enhancements

  * Delegator delegates the command execution to an execute(argv) methods,
    therefore mimicing Single command
  * Command provides subcommand_by_name (a class method) allowing to resolve 
    ':' qualified command names easily. Robustness::has_command! has been
    rewritten to use the latter method, so that it now striclty respects command
    hierarchy  
  * Delegator.summarized_subcommands takes an optional argument, allowing
    to specify the list of commands for which documentation must be summarized. 
  * The factory methods Quickl::Command and Quickl::Delegator accept an optional 
    block which is yield with the command builder.
  * Command::Builder has a command_parent= accessor allowing to bypass the default 
    (infered) command strategy feature (advanced usage).
  * Command::Builder accepts callback blocks that are called when a command is 
    installed (advanced usage).

* On the devel side

  * The project structure is handled by ruby.noe 1.3.0

# 0.2.0 / 2011-01-10

* Enhancements

  * Command#run now takes a (optional) second argument (get it at command runtime via :requester reader)
  * Renamed Delegate -> Delegator (Quickl::Delegate is kept but should not be used anymore)
  * Added IOAccessError with default reaction to Exit
  * Added valid_read_file! robustness utility
  * Moved to rspec 2.4.0, modified Rakefile and tests accordingly  

# 0.1.1 / 2010-12-24

* Fixed gemspec and binaries problems
* First official release

# 0.1.0 / 2010-12-22

* Birthday!

