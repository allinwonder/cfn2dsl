class Condition
  include CfnParser
  attr_reader(:name, :evaluations)

  def initialize(name, eval)
    @name        = name
    @evaluations = translate_cfn_functions(eval)
  end

  # def to_s
  #   %Q^  Condition("#{name}", #{evaluations.ai})^
  # end
end
