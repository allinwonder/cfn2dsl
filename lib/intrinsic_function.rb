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
    argements_str = ""
    parameters.each do |p|
      if p.instance_of? String
        argements_str += '"' + p + '", '
      else
        argements_str += parameters.to_s + ', '
      end
    end
    self.name.delete(':') + "(" + argements_str.sub(/,\s*$/, '') + ")"
  end

  alias_method :inspect, :to_s
end
