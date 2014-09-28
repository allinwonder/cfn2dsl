class Output
  include CfnParser

  ATTRIBUTES = [
    :value,
    :condition,
    :description
  ]

  attr_reader(:name, *ATTRIBUTES)

  def initialize(name, json)
    @name = name
    ATTRIBUTES.each {|a| attribute(a, json)}
  end

  private
  def attribute(name, json)
    key = name.to_s.camel_case
    if json[key]
      value = parse_cfn_json(json[key])
      instance_variable_set("@" + name.to_s, value)
    end
  end
end

