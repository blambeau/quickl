module Minicom
  class Catalog
    
    # Methods automatically installed on
    # the catalog itself
    module ClassMethods
      
      # The command catalog
      attr_accessor :catalog
      
      # Raises an error as Catalog is an abstract 
      # class
      def new
        raise "Minicom catalogs may not be instantiated"
      end
      
      # Returns the array of defined commands and/or sub catalogs
      # in the catalog
      def children
        @children ||= []
      end
      
      # Returns the array of defined commands in the catalog
      def commands
        children.select{|s| s.ancestors.include?(Command)}
      end
      
    end # module ClassMethods
    
    # Tracks child classes
    def self.inherited(catalog)
      # install class methods
      catalog.extend(ClassMethods)

      # install hierarchy
      parent = RubyTools::parent_module(catalog)
      if Minicom.looks_a_catalog?(parent)
        catalog.catalog = parent
        parent.children << catalog
      end
      
      catalog
    end
    
  end # class Catalog
end # module Minicom