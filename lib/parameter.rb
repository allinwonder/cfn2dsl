require 'extlib'
class Parameter
  ELEMENTS = [
    :name,
    :type,
    :default,
    :description,
    :allowed_values,
    :allowed_pattern,
    :no_echo,
    :max_length,
    :min_length,
    :max_value,
    :min_value,
    :constraint_description
  ]

  attr_reader(*ELEMENTS)

  def initialize(name, cfn_hash)
    @name = name
    ELEMENTS.each do |e|
      key_name = e.to_s.camel_case
      instance_variable_set('@' + e.to_s, cfn_hash[key_name]) if cfn_hash[key_name]
    end
  end
end
