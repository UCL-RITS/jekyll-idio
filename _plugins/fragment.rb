module Jekyll
  class FragmentTag < Liquid::Tag
    Syntax = /([^,]*)(?:\s*,\s*(.*))?/o
    
    def initialize(tag_name, markup, tokens)
      super

      if markup =~ Syntax
        print $2
        if $2
          @path = $2.strip
        else
          @path = nil
        end
          
	      @label = $1.downcase.strip.gsub('"','')
       
      else
        raise SyntaxError.new("Syntax error in idio fragment parsing: #{markup}")
      end
    end

    def render(context)

      config=  context.registers[:site].config.fetch("idio",{})
  
      if @path.nil?
        @path = config["path"]
      end
  
      # For now, very inefficient, search and split file every time.
      # We could cache this
	  
      extension = File.extname(@path).sub('.','')
        
      case extension
          when "py"
            @language = "python"
            @separator = "###"
          when "rb"
            @language = "ruby"
            @separator = "###"
          when "cpp", 'h', 'hpp'
            @language = "cpp"
            @separator = "///"
          when "java"
            @language = "java"
            @separator = "///"
          when "js"
            @language = "javascript"
            @separator = "///"
          else
            @separator = "###"
            @language = ""
      end
  
  
      autofence = config.fetch("fence", false)
  
      here = File.dirname(context.registers[:page]["path"])
  
      content = File.read(File.join(here, @path))
       
      file_section_expression = /^\s*#{@separator}\s*(.*)\s*$/
        
      raw_sections = content.split(file_section_expression)
      
      raw_sections = ["Beginning"]+raw_sections
      
      sections= raw_sections.each_slice(2).map{ |k, v| 
        [k.downcase.gsub('"','') , v] }.to_h
      
      if not sections.keys.include?(@label)
        raise SyntaxError.new("No such idio section as #{@label} in #{@path}. Available: #{sections.keys} ")
      end
      
      if autofence
        result = "``` #{@language}\n#{sections[@label]}\n```\n"
      else    
        return sections[@label]
      end
    end
  end
  
  Liquid::Template.register_tag('fragment'.freeze, FragmentTag)
end
