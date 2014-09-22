module CfnParser

  DESCRIPTION_KEY_NAME           = "Description"
  PROPERTIES_BLOCK_KEY_NAME      = "Properties"
  CONDITION_KEY_NAME             = "Condition"


  def escape_double_quote(str)
    str.gsub('"', %q(\\\"))
  end

  def translate_cfn_functions(json)
    send(underscore(element_type(json)), json)
  end

  def array(json)
    return json.map { |a| translate_cfn_functions(a) }
  end

  def intrinsic_function?(obj)
    obj.instance_of?(Hash) &&
    obj.keys.size == 1 &&
    (obj.keys.first =~ /^Fn::/ or obj.keys.first == "Ref")
  end

  def intrinsic_function(json)
    fn_name    = json.keys.first
    values     = json[fn_name]
    parameters = translate_cfn_functions(values)
    return IntrinsicFunction.new(fn_name, parameters: parameters)
  end

  def hash(json)
    return json.merge(json) { |k, v| translate_cfn_functions(v) }
  end

  def primitive(json)
    json
  end

  def condition?(name)
    result = false
    case name
    when CONDITION_KEY_NAME
      result = true
    end
    return result
  end

  private
  def element_type(json)
    return :Array if json.instance_of?(Array)
    return :IntrinsicFunction if intrinsic_function?(json)
    return :Hash if json.instance_of?(Hash)
    :Primitive
  end

  def underscore(camel_cased_word)
    camel_cased_word.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end

