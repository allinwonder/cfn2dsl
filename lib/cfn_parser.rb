module CfnParser

  def parse_cfn_json(json)
    send(element_type(json).to_s.snake_case, json)
  end

  def intrinsic_function?(obj)
    obj.instance_of?(Hash) &&
    obj.keys.size == 1 &&
    (obj.keys.first =~ /^Fn::/ or obj.keys.first == "Ref")
  end

  def array(json)
    return json.map { |a| parse_cfn_json(a) }
  end

  def intrinsic_function(json)
    fn_name    = json.keys.first
    values     = json[fn_name]
    parameters = parse_cfn_json(values)
    return IntrinsicFunction.new(fn_name, parameters)
  end

  def hash(json)
    return json.merge(json) { |k, v| parse_cfn_json(v) }
  end

  def primitive(json)
    json
  end

  private
  def element_type(json)
    return :Array             if json.instance_of?(Array)
    return :IntrinsicFunction if intrinsic_function?(json)
    return :Hash              if json.instance_of?(Hash)
    return :Primitive
  end
end

