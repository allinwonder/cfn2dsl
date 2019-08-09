class Output
  include CfnParser

  ATTRIBUTES = [
    :value,
    :condition,
    :description
  ]

  attr_reader(:name, *ATTRIBUTES)

  def initialize(name, cfn_hash)
    @name = name
    ATTRIBUTES.each {|a| attribute(a, cfn_hash)}
  end

  private
  def attribute(name, cfn_hash)
    key = name.to_s.camel_case
    if cfn_hash[key]
      value = parse_cfn(cfn_hash[key])
      instance_variable_set("@" + name.to_s, value)
    end
  end
end

