# 0.4.0 / FIX ME

* Enhancements

  * The hard-coded way of extracting command documentation as source rdoc has
    been replaced by a Command.doc_extractor (a Proc) which can be installed 
    through the command builder (advanced usage). Default behavior is kept 
    unchanged, though.
  * Command.documentation now takes an optional Hash of options, which is passed 
    as second argument to the documentation extractor (the first one being the 
    command class itself).

* Breaking changes

  * Command#method_missing and well as the Robustness module have been removed
    after deprecation.
  * Command.doc_place and Command.doc_src have been removed as well.

# 0.3.0 / 2011-07-29

* Upgrading from 0.2.x

This release is mostly compatible with the 0.2.x branch, but may require a few 
changes to your code to avoid deprecation warnings and prepare for 0.4.0 that 
will break if you don't. From the most to the less likely:

  * If you originally copied the Help command from examples, please do it again
    on the new version. The execute method of Help should be:

      sup = Quickl.super_command(self)
      sub = (args.size != 1) ? sup : Quickl.sub_command!(sup, args.first)
      puts Quickl.help(sub)

  * If you use `usage`, `help`, `overview` or any similar methods in the context
    of a command (instance or class, except in rdoc-based documentation), please
    use the equivalent module methods provided by Quickl.

  * If you use methods provided by the Robustness module, notably valid_read_file!
    and has_subcommand!, please use module methods provided by Quickl instead.

  * If you override Command#_run, please now override Command#run instead.

  * If you rescue SystemExit when executing Command#run, please now rescue 
    Quickl::Error (or any subclass) instead. No change is required if you rescue
    when executing Command.run, or if you don't rescue on errors at all.

* Bug fixes

  * A single dash option (e.g. -v) is now correctly recognized by a Delegator
    command ("No such command -v" was previously raised) 

* Enhancements

  * Added Quickl.[command_name,super_command,sub_command,help,overview,usage,
    documentation] as convenient query methods on commands and their hierarchy. 
    These helpers work both on command instances and on command classes and will 
    be part of the public API when stabilized (the same methods on the Command 
    class should be considered private from now on; if you use them, please 
    upgrade).

  * Added Quickl.parse_commandline_args that converts a commandline string to
    an ARGV array. This is mainly provided for testing purposes.

  * Added Quickl.split_commandline_args to split ARGV on the "--" option 
    separator

  * Command#parse_options now accepts a second option that allows specifying
    the behavior in presence of '--' option separators. Default behavior is
    backward compatible and conforms to getopt(1). :keep and :split can be used
    to keep separators in result, or split the latter on separators. Thanks to
    Brian Candler for pointing to getopt(1) for specification.

* Deprecations 

The following methods are deprecated and will be removed in 0.4.0 (run with 
ruby -w to see where refactoring is needed). Examples have been adapted and can 
be copy-pasted safely.

  * Command#method_missing auto-delegation from command instances to command 
    classes is deprecated. Please use explicit calls to command methods on the 
    class itself, or tools provided by the Quickl module itself.

  * The robustness methods available in command instances, notably valid_read_file! 
    and has_command! are deprecated and replaced by convenient helpers available 
    as module methods of Quickl itself. The Robustness module will disappear in
    0.4.0.

* Possibly hurting changes to the internals

  * An unused and undocumented `args` attribute (attr_reader) has been removed 
    from Single commands instances.  

  * No default behavior is implemented in Command#run anymore (call was 
    previously delegated to _run and surrounded in a begin/rescue/end block). 
    The method is now directly implemented in Single and Delegator subclasses. 
    This may break your code if it redefines _run.
    
  * Error catching is done in Command.run instead of Command#run. The way to 
    specify how to react to errors did not change.  

# 0.2.2 / 2011.07.12

* Enhancements

  * Added a template/delegator.erb template (quickl --layout=delegator ...)
  * Added --[no-]header and --[no-]footer options to the template generator

* Bug fixes

  * The gem is now shipped with the template/single.erb file. This fixes the 
    'quickl' commandline that generates skeletons as illustrated in README 
    (patch and thanks to Rit Li)
  * Broken links to the examples from the README are fixed (Travis Briggs)
  * Other typos fixed that led to failures on --help in examples (Tomasz Łoszko)

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

