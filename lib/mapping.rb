class Mapping
  include CfnParser
  attr_accessor(:name, :values)

  def initialize(name, values)
    self.name   = name
    self.values = translate_cfn_functions(values)
  end

  def to_s
    %Q^  Mapping("#{name}", #{values.ai})^
  end
  alias_method :inspect, :to_s
end
