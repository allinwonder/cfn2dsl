class Mapping
  include CfnParser
  attr_reader(:name, :values)

  def initialize(name, values)
    @name   = name
    @values = translate_cfn_functions(values)
  end

  # def to_s
  #   %Q^  Mapping("#{name}", #{values.ai})^
  # end
end
