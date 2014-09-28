require 'extlib'
class CloudFormation

  ELEMENTS = [
    :parameters,
    :resources,
    :conditions,
    :outputs,
    :mappings,
    :description,
    :aws_template_format_version
  ]

  attr_reader(*ELEMENTS)

  def initialize(json)
    ELEMENTS.each do |e|
      key  = e.to_s.camel_case
      if key =~ /^Aws/
        key = key.sub(/^Aws/, "AWS")
      end

      if json[key]
        attr = parse_element(e, json[key])
        instance_variable_set("@" + e.to_s, attr)
      end
    end
  end

  private
  def parse_element(elm_name, json)
    function = parser(elm_name)
    send(function, elm_name, json)
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

  def simple_parser(name, json)
    json
  end

  def complex_parser(name, json)
    elms = []
    case name
    when :parameters
      json.each_pair { |k, v| elms << Parameter.new(k, v) }
    when :resources
      json.each_pair { |k, v| elms << Resource.new(k, v) }
    when :outputs
      json.each_pair { |k, v| elms << Output.new(k, v) }
    when :mappings
      json.each_pair { |k, v| elms << Mapping.new(k, v) }
    when :conditions
      json.each_pair { |k, v| elms << Condition.new(k, v) }
    end
    return elms
  end
end
