module Minicom
  class Command
    
    # Methods installed on the class
    module ClassMethods
      
      # The command catalog
      attr_accessor :catalog
      
      # Command's summary
      attr_accessor :summary
      
      # Command's usage
      attr_accessor :usage
      
      # Command's description
      attr_accessor :description
      
    end # module ClassMethods
    
    # Tracks child classes
    def self.inherited(command)
      # create the command
      command.extend(ClassMethods)
      
      # install documentation
      Minicom.consume_tracking do |file,line|
        rdoc = RubyTools::extract_file_rdoc(file, line, true)
        rdoc = RubyTools::rdoc_paragraphs(rdoc)
        command.summary     = rdoc.shift
        command.usage       = rdoc.shift.strip
        command.description = rdoc.join("\n")
      end

      # install hierarchy
      parent = RubyTools::parent_module(command)
      if Minicom.looks_a_catalog?(parent)
        command.catalog = parent
        parent.children << command
      else
        raise "Invalid command hierarchy, #{parent} is not a command catalog"
      end
      
      command
    end
    
  end # class Command
end # module Minicom