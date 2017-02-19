require 'erubis'
class Render

  attr_reader :cfn

  def initialize(cfn)
    @cfn = cfn
  end

  def cfn_to_cfndsl
    input = File.read("#{File.dirname(__FILE__)}/cfndsl.erb")
    context = { :cfn => @cfn }
    Erubis::Eruby.new(input).evaluate(context).to_s.gsub('"', '\'')
  end
end
