class Resource
  include CfnParser
  attr_accessor :name, :type, :properties, :attributes, :condition

  def initialize(name, json)
    self.name       = name
    self.type       = json[TYPE_KEY_NAME]
    self.attributes = {}
    if json[PROPERTIES_BLOCK_KEY_NAME].keys.size > 0
      ps = json[PROPERTIES_BLOCK_KEY_NAME]
      self.properties = ps.merge(ps) do |k, v|
        translate_cfn_functions(v)
      end
    end

    json.each_pair do |k, v|
      if attribute? k
        self.attributes[k] = translate_cfn_functions(v)
      end
    end

    if json[CONDITION_KEY_NAME]
      self.condition  = translate_cfn_functions(json[CONDITION_KEY_NAME])
    end
  end

  def to_s
    ss = [%Q^  Resource("#{name}") do^]
    ss << %Q^    Type("#{type}")^
    ss << %Q^    Condition("#{condition}")^ if condition
    if attributes
      attributes.each_pair do |name, value|
          ss << %Q^    #{name}(#{value.ai})^
      end
    end
    if properties
      properties.each_pair do |name, value|
        ss << %Q^    Property("#{name}", #{value.ai})^
      end
    end
    ss << "  end"
    ss.join("\n")
  end
end
