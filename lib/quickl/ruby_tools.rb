module Quickl
  module RubyTools

    # Returns the parent module of a class
    def parent_module(clazz)
      name = clazz.name
      (name =~ /^(.*?)::([^:]+)$/) ? Kernel.eval($1) : nil
    end
    module_function :parent_module

    # Returns the unqualified name of a class
    def class_unqualified_name(clazz)
      name = clazz.name
      (name =~ /::([^:]+)$/) ? $1 : name
    end
    module_function :class_unqualified_name

    # Makes a call to a block that accepts optional arguments
    def optional_args_block_call(block, args)
      if RUBY_VERSION >= "1.9.0"
        if block.arity == 0
          block.call
        else
          block.call(*args)
        end
      else
        block.call(*args)
      end
    end
    module_function :optional_args_block_call

    # Extracts the rdoc of a given ruby file source.
    def extract_file_rdoc(file, from = nil, reverse = false)
      lines = File.readlines(file)
      if from.nil? and reverse
        lines = lines.reverse
      elsif !reverse
        lines = lines[(from || 0)..-1]
      else
        lines = lines[0...(from || -1)].reverse
      end
      
      doc, started = [], false
      lines.each{|line|
        if /^\s*[#]/ =~ line
          doc << line
          started = true
        elsif started
          break
        end 
      }
      
      doc = reverse ? doc.reverse[0..-1] : doc[0..-1]
      doc = doc.join("\n")
      doc.gsub(/^\s*[#] ?/, "")
    end
    module_function :extract_file_rdoc

  end # module RubyTools
end # module Quickl