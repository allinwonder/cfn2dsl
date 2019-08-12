require 'extlib'
require 'psych'
class CloudFormation

  ELEMENTS = [
    :parameters,
    :resources,
    :conditions,
    :outputs,
    :mappings,
    :rules,
    :metadata,
    :description,
    :aws_template_format_version
  ]

  attr_reader(*ELEMENTS)

  def initialize(cfn_string)
    cfn_hash = Psych.safe_load(cfn_string)
    ELEMENTS.each do |e|
      key  = e.to_s.camel_case
      if key =~ /^Aws/
        key = key.sub(/^Aws/, "AWS")
      end

      if cfn_hash[key]
        attr = parse_element(e, cfn_hash[key])
        instance_variable_set("@" + e.to_s, attr)
      end
    end
  rescue Psych::DisallowedClass => error
    raise Exception.new "Invalid YAML. Only simple scalars are supported. #{error.message}. Check that values are quoted."
  rescue Psych::Exception => error
    raise Exception.new "Invalid YAML. #{error.message}"    
  end

  private
  def parse_element(elm_name, cfn_hash)
    function = parser(elm_name)
    send(function, elm_name, cfn_hash)
  end

  def parser(name)
    case name
    when :description
      :simple_parser
    when :aws_template_format_version
      :simple_parser
    else
      :complex_parser
    end
  end

  def simple_parser(name, cfn_hash)
    cfn_hash
  end

  def complex_parser(name, cfn_hash)
    elms = []
    case name
    when :metadata
      cfn_hash.each_pair { |k, v| elms << Metadata.new(k, v) }
    when :rules
      cfn_hash.each_pair { |k, v| elms << Rules.new(k, v) }
    when :parameters
      cfn_hash.each_pair { |k, v| elms << Parameter.new(k, v) }
    when :resources
      cfn_hash.each_pair { |k, v| elms << Resource.new(k, v) }
    when :outputs
      cfn_hash.each_pair { |k, v| elms << Output.new(k, v) }
    when :mappings
      cfn_hash.each_pair { |k, v| elms << Mapping.new(k, v) }
    when :conditions
      cfn_hash.each_pair { |k, v| elms << Condition.new(k, v) }
    end
    return elms
  end
end
