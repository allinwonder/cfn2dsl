module CfnParser

  def parse_cfn(cfn_hash)
    send(element_type(cfn_hash).to_s.snake_case, cfn_hash)
  end

  def intrinsic_function?(obj)
    obj.instance_of?(Hash) &&
    obj.keys.size == 1 &&
    (obj.keys.first =~ /^Fn::/ or obj.keys.first == "Ref")
  end

  def array(cfn_hash)
    return cfn_hash.map { |a| parse_cfn(a) }
  end

  def intrinsic_function(cfn_hash)
    fn_name    = cfn_hash.keys.first
    values     = cfn_hash[fn_name]
    parameters = parse_cfn(values)
    return IntrinsicFunction.new(fn_name, parameters)
  end

  def hash(cfn_hash)
    return cfn_hash.merge(cfn_hash) { |k, v| parse_cfn(v) }
  end

  def primitive(cfn_hash)
    cfn_hash
  end

  private
  def element_type(cfn_hash)
    return :Array             if cfn_hash.instance_of?(Array)
    return :IntrinsicFunction if intrinsic_function?(cfn_hash)
    return :Hash              if cfn_hash.instance_of?(Hash)
    return :Primitive
  end
end

