class Output
  include CfnParser
  attr_accessor(:name, :description, :value, :condition)

  def initialize(name, json)
    self.name        = name
    self.value       = json[VALUE_KEY_NAME]
    self.description = json[DESCRIPTION_KEY_NAME] if json[DESCRIPTION_KEY_NAME]
    self.condition   = json[CONDITION_KEY_NAME]   if json[CONDITION_KEY_NAME]
  end

  def to_s
    ss = [%Q^  Output("#{name.to_s}") do^]
    ss << %Q^    Value(#{value.to_s})^

    ss << %Q^    Description(#{description.to_s})^  if self.description
    ss << %Q^    Condition(#{self.condition.to_s})^ if self.condition
    ss << "  end"
    ss.join("\n")
  end
  alias_method :inspect, :to_s
end

