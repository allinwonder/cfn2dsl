class Resource
  include CfnParser

  ATTRIBUTES = [
    :deletion_policy,
    :depends_on,
    :metadata,
    :update_policy,
    :condition,
    :type,
    :properties
  ]

  attr_reader(:name, *ATTRIBUTES)

  def initialize(name, json)
    @name = name
    ATTRIBUTES.each do |a|
      send(attribute_type(a), json, a.to_s)
    end
  end

  private
  def attribute_type(name)
    type = ''
    case name
    when name == :properties || name == :metadata || name == :update_policy
      type = "complex_attribute"
    else
      type = "basic_attribute"
    end
    return type
  end

  def complex_attribute(json, name)
    if json[name.camel_case]
      values = json[name.camel_case].merge do |k, v|
        parse_cfn_json(v)
      end
      instance_variable_set('@' + name, values)
    end
  end

  def basic_attribute(json, name)
    if json[name.camel_case]
      instance_variable_set('@' + name, parse_cfn_json(json[name.camel_case]))
    end
  end
end
