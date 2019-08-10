class IntrinsicFunction
  attr_reader :name, :parameters

  def initialize(name, parameters)
    @name = name
    @parameters = parameters
  end

  def to_s
    function_name = @name.delete(':').snake_case
    send(function_name)
  end

  alias_method :inspect, :to_s

  def ==(o)
    o.instance_of?(IntrinsicFunction) and o.name == @name and @parameters == o.parameters
  end

  private
  def fn_base64
    if @parameters.instance_of? String
      value = "'#{@parameters}'"
    else
      value = @parameters.ai
    end
    return "FnBase64 '#{value}'"
  end

  def fn_select
    return "FnSelect(#{@parameters[0]}, #{@parameters[1..@parameters.size].ai})"
  end

  def ref
    return "Ref('#{@parameters.gsub('\''){'\\\''}}')"
  end

  def fn_and
    return "FnAnd(#{@parameters.ai})"
  end

  def fn_equals
    if @parameters[0].instance_of? String
      arg1 = '\'' + @parameters[0].gsub('\''){'\\\''} + '\''
    else
      arg1 = @parameters[0].ai
    end

    if @parameters[1].instance_of? String
      arg2 = '\'' + @parameters[1].gsub('\''){'\\\''} + '\''
    else
      arg2 = @parameters[1].ai
    end

    return "FnEquals(#{arg1}, #{arg2})"
  end

  def fn_if
    cond_name = '\'' + @parameters[0].gsub('\''){'\\\''} + '\''
    if @parameters[1].instance_of? String
      true_value = '\'' + @parameters[1].gsub('\''){'\\\''} + '\''
    else
      true_value = @parameters[1].ai
    end

    if @parameters[2].instance_of? String
      false_value = '\'' + @parameters[2].gsub('\''){'\\\''} + '\''
    else
      false_value = @parameters[2].ai
    end
    return "FnIf(#{cond_name}, #{true_value}, #{false_value})"
  end

  def fn_not
    return "FnNot(#{@parameters.ai})"
  end

  def fn_or
    return "FnOr(#{@parameters.ai})"
  end

  def fn_find_in_map
    map_name = '\'' + @parameters[0] + '\''

    if @parameters[1].instance_of? String
      top_level_key = '\'' + @parameters[1] + '\''
    else
      top_level_key = @parameters[1].ai
    end

    if @parameters[2].instance_of? String
      sec_level_key = '\'' + @parameters[2] + '\''
    else
      sec_level_key = @parameters[2].ai
    end

    return "FnFindInMap(#{map_name}, #{top_level_key}, #{sec_level_key})"
  end

  def fn_get_att
    resource_name = '\'' + @parameters[0] + '\''
    attr_name     = '\'' + @parameters[1] + '\''
    return "FnGetAtt(#{resource_name}, #{attr_name})"
  end

  def fn_join
    seperator = '\'' + @parameters[0].gsub('\''){'\\\''} + '\''
    values    = @parameters[1].ai
    return "FnJoin(#{seperator}, #{values})"
  end

  def fn_sub
   if @parameters.instance_of? String
     value = '"' + @parameters.gsub('"'){'\\"'} + '"'
     return "FnSub(#{value})"
   else
     origin = '"' + @parameters[0].gsub('"'){'\\"'} + '"'
     values    = @parameters[1].ai
     return "FnSub(#{origin}, #{values})"
   end
  end

  def fn_split
    delimiter = '"' + @parameters[0].gsub('"'){'\\"'} + '"'
    # value     = '"' + @parameters[1] + '"'
    if @parameters[1].instance_of? String
       value     = '"' + @parameters[1] + '"'
    else
      value = @parameters[1].ai
    end
    return "FnSplit(#{delimiter}, #{value})"
  end

  def fn_import_value
    value     = '"' + @parameters[0] + '"'
    return "FnImportValue(#{value})"
  end

  def fn_get_a_zs
    if @parameters.instance_of? String
      value = '\'' + @parameters.gsub('\''){'\\\''} + '\''
    else
      value = @parameters.ai
    end
    
    return "FnGetAZs(#{value})"
  end
  

end
