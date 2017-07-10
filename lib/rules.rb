class Rules
  include CfnParser
  attr_reader(:name, :values)

  def initialize(name, values)
    @name   = name
    @values = parse_cfn_json(values)
  end
end
