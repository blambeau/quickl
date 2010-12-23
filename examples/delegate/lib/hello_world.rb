class Delegate
  #
  # Say hello 
  #
  # SYNOPSIS
  #   delegate hello-world [--capitalize] [WHO]
  #
  # OPTIONS
  # #{summarized_options}
  #
  # DESCRIPTION
  #   Without any argument, says hello to the world. When a single argument 
  #   is given says hello to the user.
  #
  class HelloWorld < Quickl::Command(__FILE__, __LINE__)
  
    # Command's version
    VERSION = "0.1.0"
  
    # Install command options
    options do |opt|

      # Capitalize user name?
      opt.on("--capitalize", "-c", "Capitalize user name") do 
        @capitalize = true
      end

    end
  
    # Execute the command on some arguments
    def execute(args)
      needless_arguments!(args, 1)
      name = args.first || "world"
      name = name.capitalize if @capitalize
      puts "Hello #{name}!"
    end
  
  end # class HelloWorld
end # class Delegate