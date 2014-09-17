class Condition
  include CfnParser
  attr_accessor(:name, :evaluations)

  def initialize(name, eval)
    self.name        = name
    self.evaluations = translate_cfn_functions(eval)
  end

  def to_s
    %Q^  Condition("#{name}", #{evaluations.ai})^
  end
end
