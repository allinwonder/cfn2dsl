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
    # arguments_str = ""
    arguments_str = parameters.map do |p|
      if p.instance_of? String
        '"' + p + '"'
      else
        parameters.ai
      end
    end
    self.name.delete(':') + "(" + arguments_str.join(',') + ")"
  end

  alias_method :inspect, :to_s
end
