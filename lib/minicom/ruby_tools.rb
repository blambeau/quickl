module Minicom
  module RubyTools

    # Returns the parent module of a class
    def parent_module(clazz)
      name = clazz.name
      if name =~ /^(.*?)::([^:]+)$/
        Kernel.eval($1)
      else
        nil
      end
    end

    # Returns the unqualified name of a class
    def class_unqualified_name(clazz)
      name = clazz.name
      if name =~ /::([^:]+)$/
        $1
      else
        name
      end
    end
    alias :unqualified_class_name :class_unqualified_name

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

    # Extracts the rdoc of a given ruby file source
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
      
      doc = reverse ? doc.reverse[0...-1] : doc[0...-1]
      doc = doc.join("\n")
      doc.gsub(/^\s*[#] ?/, "")
    end

    # Splits a text obtained through extract_file_rdoc into paragraphs
    def rdoc_paragraphs(rdoc_text)
      paragraphs, current = [], ""
      rdoc_text.each_line do |s|
        if s.strip.empty?
          unless current.strip.empty?
            paragraphs << current 
          end
          current = ""
        else
          current << s
        end
      end
      unless current.strip.empty?
        paragraphs << current 
      end
      paragraphs
    end

    # Convenient method for <code>rdoc_paragraphs(extract_file_rdoc(file))</code>
    def rdoc_file_paragraphs(file)
      rdoc_paragraphs(extract_file_rdoc(file))
    end

    extend(RubyTools)
  end # module RubyTools
end # module Minicom