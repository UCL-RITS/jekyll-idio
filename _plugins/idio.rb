class Idio < Liquid::Block
  def initialize(tag_name, markup, tokens)
     super
     @path = markup.strip.gsub('"','')
  end

  def render(context)
   	config=  context.registers[:site].config.fetch("idio",{})
    config['path']=@path
    context.registers[:site].config["idio"]=config
    super
  end
end

Liquid::Template.register_tag('idio', Idio)