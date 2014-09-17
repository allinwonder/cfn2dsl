class IntrinsicFunction
  attr_accessor :name, :parameters

  def initialize(name, parameters: [])
    self.name = name
    if ! parameters.instance_of? Array
      self.parameters = [parameters]
    else
      self.parameters = parameters
    end
  end

  def to_s
    arguments_str = ""
    parameters.each do |p|
      if p.instance_of? String
        arguments_str += '"' + p + '", '
      else
        arguments_str += parameters.ai + ', '
      end
    end
    self.name.delete(':') + "(" + arguments_str.sub(/,\s*$/, '') + ")"
  end

  alias_method :inspect, :to_s
end
