class Parameter
  include CfnParser

  TYPE_KEY_NAME       = "Type"
  NO_ECHO_KEY_NAME    = "NoEcho"
  MAX_LENGTH_KEY_NAME = "MaxLength"
  MIN_LENGTH_KEY_NAME = "MinLength"
  MAX_VALUE_KEY_NAME  = "MaxValue"
  MIN_VALUE_KEY_NAME  = "MinValue"
  DEFAULT_KEY_NAME    = "Default"

  CONSTRAIN_DESCRIPTION_KEY_NAME = "ConstrainDescription"
  ALLOWED_VALUES_KEY_NAME        = "AllowedValues"
  ALLOWED_PATTERN_KEY_NAME       = "AllowedPattern"

  attr_accessor(:name, :type, :default, :description, :allowed_values,
    :allowed_pattern, :no_echo, :max_length, :min_length, :max_value,
    :min_value, :constrain_description)

  def initialize(name, json)
    # TODO: type validation is require
    self.name = name
    self.type = json[TYPE_KEY_NAME]

    if json[NO_ECHO_KEY_NAME]
      self.no_echo = json[NO_ECHO_KEY_NAME]
    end

    if json[MAX_LENGTH_KEY_NAME] and json[MAX_LENGTH_KEY_NAME].to_i > 0
      self.max_length = json[MAX_LENGTH_KEY_NAME].to_i
    end

    if json[MIN_LENGTH_KEY_NAME] and json[MIN_LENGTH_KEY_NAME].to_i >= 0
      self.min_length = json[MIN_LENGTH_KEY_NAME].to_i
    end

    if json[MAX_VALUE_KEY_NAME]
      self.max_value = json[MAX_VALUE_KEY_NAME]
    end

    if json[MIN_VALUE_KEY_NAME]
      self.min_value = json[MIN_VALUE_KEY_NAME]
    end

    if json[DEFAULT_KEY_NAME]
      self.default = json[DEFAULT_KEY_NAME]
    end

    if json[DESCRIPTION_KEY_NAME]
      self.description = json[DESCRIPTION_KEY_NAME]
    end

    if json[CONSTRAIN_DESCRIPTION_KEY_NAME]
      self.constrain_description = json[CONSTRAIN_DESCRIPTION_KEY_NAME]
    end

    if json[ALLOWED_VALUES_KEY_NAME]
      self.allowed_values = []
      json[ALLOWED_VALUES_KEY_NAME].each do |v|
          self.allowed_values << v.to_s
      end
    end

    if json[ALLOWED_PATTERN_KEY_NAME] != ""
      self.allowed_pattern = json[ALLOWED_PATTERN_KEY_NAME]
    end
  end

  def to_s
    ss = ["  Parameter(\"#{name}\") do"]
    ss << "    Type(\"#{type}\")"
    ss << %Q^    Default("#{escape_double_quote default.to_s}")^         if default
    ss << %Q^    Description("#{escape_double_quote description.to_s}")^ if description
    ss << %Q^    NoEcho("#{no_echo.to_s}")^            if no_echo

    if allowed_values
      ss << %Q^    AllowedValues(#{allowed_values})^
    end

    if allowed_pattern
      ss << %Q^    AllowedPattern("#{escape_double_quote allowed_pattern.to_s}")^
    end

    ss << %Q^    MaxLength(#{max_length})^ if max_length
    ss << %Q^    MinLength(#{min_length})^ if min_length
    ss << %Q^    MaxValue(#{max_value})^   if max_value
    ss << %Q^    MinValue(#{min_value})^   if min_value

    if constrain_description
      ss << %Q^    ConstrainDescription("#{escape_double_quote constrain_description}")^
    end

    ss << "  end"
    ss.join("\n")
  end
  alias :inspect :to_s
end
