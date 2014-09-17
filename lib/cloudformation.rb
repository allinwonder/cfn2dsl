class CloudFormation
  include CfnParser
  def self.from_json(json)
    blocks, opts = {}, {}
    resources_block   = json["Resources"] if json["Resources"]

    opts[:description] = json["Description"] if json["Description"]
    opts[:version]     = json["AWSTemplateFormatVersion"] if json["AWSTemplateFormatVersion"]

    blocks[:parameters]  = json["Parameters"] if json["Parameters"]
    blocks[:outputs]     = json["Outputs"] if json["Outputs"]
    blocks[:mappings]    = json["Mappings"] if json["Mappings"]
    blocks[:conditions]  = json["Conditions"] if json["Conditions"]

    if blocks[:parameters]
      parameters = []
      blocks[:parameters].each_pair do |n, v|
        parameters << Parameter.new(n, v)
      end
      opts[:parameters] = parameters
    end

    if blocks[:mappings]
      mappings = []
      blocks[:mappings].each_pair do |n, v|
        mappings << Mapping.new(n, v)
      end
      opts[:mappings] = mappings
    end

    if blocks[:conditions]
      conditions = []
      blocks[:conditions].each_pair do |n, v|
        conditions << Condition.new(n, v)
      end
      opts[:conditions] = conditions
    end

    if blocks[:outputs]
      outputs = []
      blocks[:outputs].each_pair do |n, v|
        outputs << Output.new(n, v)
      end
      opts[:outputs] = outputs
    end

    resources = []
    resources_block.each_pair do |n, v|
      resources << Resource.new(n, v)
    end

    return CloudFormation.new(resources, opts)
  end

  def initialize(resources, description: "", version: "2010-09-09",
    parameters: [], conditions: [], outputs: [], mappings: [])
    self.resources   = resources
    self.version     = version
    self.description = description if description != ""
    self.parameters  = parameters  if parameters.size > 0
    self.conditions  = conditions  if conditions.size > 0
    self.outputs     = outputs     if outputs.size > 0
    self.mappings    = mappings    if mappings.size > 0
  end

  attr_accessor(:description, :parameters, :resources, :conditions, :outputs,
    :version, :mappings)

  def to_s
    ss = [%Q^CloudFormation do^]
    ss << %Q^  AWSTemplateFormatVersion("#{version}")^

    if description != ""
      ss << %Q^  Description("#{description}")^
    end

    if parameters
      parameters.each do |param|
        ss << param
      end
    end

    if mappings
      mappings.each do |map|
        ss << map
      end
    end

    if conditions
      conditions.each do |con|
        ss << con
      end
    end

    resources.each do |res|
      ss << res
    end

    if outputs
      outputs.each do |out|
        ss << out
      end
    end

    ss << "end"

    ss.join("\n")
  end

  alias_method :inspect, :to_s
end
