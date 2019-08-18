class Resource
  include CfnParser

  ATTRIBUTES = [
    :deletion_policy,
    :depends_on,
    :metadata,
    :update_policy,
    :condition,
    :type,
    :properties,
    :creation_policy
  ]

  attr_reader(:name, *ATTRIBUTES)

  def initialize(name, cfn_hash)
    @name = name
    ATTRIBUTES.each do |a|
      send(attribute_type(a), cfn_hash, a.to_s)
    end
  end

  private
  def attribute_type(name)
    type = ''
    case name
    when name == :properties    ||
         name == :metadata      || 
         name == :update_policy ||
         name == :depends_on    || 
         name == :creation_policy
      type = "complex_attribute"
    else
      type = "basic_attribute"
    end
    return type
  end

  def complex_attribute(cfn_hash, name)
    if cfn_hash[name.camel_case]
      values = cfn_hash[name.camel_case].merge do |k, v|
        parse_cfn(v)
      end
      instance_variable_set('@' + name, values)
    end
  end

  def basic_attribute(cfn_hash, name)
    if cfn_hash[name.camel_case]
      instance_variable_set('@' + name, parse_cfn(cfn_hash[name.camel_case]))
    end
  end
end
