require 'quickl/loader'
require 'quickl/version'
require 'quickl/ext/object'
require 'quickl/errors'
require 'quickl/ruby_tools'
require 'quickl/naming'
require 'quickl/command'
module Quickl

  # Quickl's COPYRIGHT info 
  COPYRIGHT = "(c) 2010-2011, Bernard Lambeau"
  
  #
  # Prints a deprecation message on STDERR if $VERBOSE is set to true
  #
  def self.deprecated(who, instead, caller)
    if $VERBOSE
      STDERR << "WARN (Quickl): #{who} is deprecated, use #{instead} "\
                "(#{caller.first})\n"
    end
  end
  
  #
  # Yields the block with the current command builder.
  # A fresh new builder is created if not already done.
  #
  # This method is part of Quickl's private interface.
  #
  def self.command_builder 
    @builder ||= Command::Builder.new
    yield @builder if block_given?
    @builder
  end
  
  #
  # Builds _command_ using the current builder. 
  #
  # The current command builder is considered consumed 
  # and removed as a side effect. A RuntimeError is raised 
  # if no builder is currently installed.
  #
  # Returns the command itself.
  #
  # This method is part of Quickl's private interface.
  #
  def self.build_command(command)
    unless @builder
      raise "No command builder currently installed"
    else
      @builder.run(command)
      @builder = nil
      command
    end
  end
  
  #
  # Convenient method for <code>File.basename($0)</code>
  #
  def self.program_name
    File.basename($0)
  end

  #
  # When `cmd` is a class, returns it. When a command instance, returns 
  # `cmd.class`. Otherwise, raises an ArgumentError.
  #
  def self.command_class(cmd)
    case cmd
    when Class
      cmd
    when Command
      cmd.class
    else
      raise ArgumentError, "Not a recognized command #{cmd}"
    end
  end

  #
  # Returns the super command of `cmd`, or nil.
  # 
  def self.super_command(cmd)
    command_class(cmd).super_command
  end

  #
  # Returns the subcommand of `cmd` which is called `name`, or nil.
  #
  def self.sub_command(cmd, name)
    command_class(cmd).subcommand_by_name(name)
  end

  #
  # Returns the subcommand of `cmd` which is called `name`. Raises a 
  # NoSuchCommand if not found.
  #
  def self.sub_command!(cmd, name)
    unless subcmd = sub_command(cmd, name)
      raise NoSuchCommand, "No such command #{name}" 
    end
    subcmd
  end

  #
  # Convenient method for <code>command_class(cmd).command_name</code>
  #
  def self.command_name(cmd)
    command_class(cmd).command_name
  end

  #
  # Convenient method for <code>command_class(cmd).usage</code>
  #
  def self.usage(cmd)
    command_class(cmd).usage
  end

  #
  # Convenient method for <code>command_class(cmd).overview</code>
  #
  def self.overview(cmd)
    command_class(cmd).overview
  end
  
  #
  # Convenient method for <code>command_class(cmd).documentation</code>
  #
  def self.documentation(cmd)
    command_class(cmd).documentation
  end
  
  #
  # Alias for documentation
  #
  def self.help(cmd)
    command_class(cmd).help
  end
  
  #
  # Checks that `file` is a readable file or raises an error. Returns `file` on 
  # success.
  #
  # @param [String] file path to a file that should exists and be readable 
  # @param [Class] error_class the error class to use on error 
  #        (Quickl::IOAccessError by default)
  # @param [String] msg a dedicated error message (a default one is provided)
  # @return [String] file on success
  #
  def self.valid_read_file!(file, error_class = nil, msg = nil)
    if File.file?(file) and File.readable?(file)
      file
    else
      error_class ||= Quickl::IOAccessError
      msg ||= "Not a file or not readable: #{file}"
      raise error_class, msg, caller
    end
  end

  #
  # Parse a string with commandline arguments and returns an array.
  #
  # Example:
  # 
  #   parse_commandline_args("--text --size=10") # => ['--text', '--size=10']
  #
  def self.parse_commandline_args(args)
    args = args.split(/\s+/)
    result = []
    until args.empty?
      quote = ['"', "'"].find{|q| q == args.first[0,1]}
      if quote
        if args.first[-1,1] == quote
          result << args.shift[1...-1]
        else
          block = [ args.shift[1..-1] ]
          while args.first[-1,1] != quote
            block << args.shift
          end 
          block << args.shift[0...-1]
          result << block.join(" ")
        end
      else
        result << args.shift
      end  
    end
    result
  end

  #
  # Splits an array `args` on '--' option separator. 
  # 
  def self.split_commandline_args(args)
    args = args.dup
    result, current = [], []
    until args.empty?
      if (x = args.shift) == "--"
        result << current
        current = []
      else
        current << x
      end
    end
    result << current
    result
  end
  
end # module Quickl
