class Delegator
  #
  # Say hello 
  #
  # SYNOPSIS
  #   #{program_name} #{command_name} [--capitalize] [WHO]
  #
  # OPTIONS
  # #{summarized_options}
  #
  # DESCRIPTION
  #   Without any argument, says hello to the world. When a single argument 
  #   is given says hello to the user.
  #
  class HelloWorld < Quickl::Command(__FILE__, __LINE__)
  
    # Install command options
    options do |opt|

      # Capitalize user name?
      opt.on("--capitalize", "-c", "Capitalize user name") do 
        @capitalize = true
      end

    end
  
    # Execute the command on some arguments
    def execute(args)
      if args.size <= 1
        name = args.first || "world"
        name = name.capitalize if @capitalize
        puts "Hello #{name}!"
      else
        raise Quickl::InvalidArgument, "Useless arguments: #{args.join(' ')}"
      end
    end
  
  end # class HelloWorld
end # class Delegator