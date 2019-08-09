YAML.add_domain_type('', 'Ref') { |type, val| { 'Ref' => val } }

YAML.add_domain_type('', 'GetAtt') do |type, val|
  if val.is_a? String
    val = val.split('.')
  end

  { 'Fn::GetAtt' => val }
end

%w(Join Base64 Sub Split Select ImportValue GetAZs FindInMap And Or If Not).each do |function_name|
  YAML.add_domain_type('', function_name) { |type, val| { "Fn::#{function_name}" => val } }
end