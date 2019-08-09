class Condition
  include CfnParser
  attr_reader(:name, :evaluations)

  def initialize(name, eval)
    @name        = name
    @evaluations = parse_cfn(eval)
  end
end
