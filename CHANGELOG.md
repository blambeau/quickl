# 0.2.1 / FIX ME

* Enhancements

  * Delegator now delegates the command execution to an execute(argv) methods
    that mimics a Single command
  * Delegator.summarized_subcommands now takes an optional argument, allowing
    to specify the list of commands for which documentation must be summarized. 
  * The factory methods Quickl::Command and Quickl::Delegator now accept an 
    optional block which is yield with the command builder when present.
  * Command::Builder has a command_parent= accessor that allow bypassing the
    default (infered) command strategy feature (advanced usage).
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

