$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'json'
require 'yaml'
require 'optparse'
require 'ap'

require 'cfn_parser'
require 'cloudformation'
require 'condition'
require 'intrinsic_function'
require 'mapping'
require 'output'
require 'parameter'
require 'resource'
require 'render'
require 'version'
require 'rules'
require 'metadata'

AwesomePrint.defaults = {
  :indent    => -2,
  :index     => false,
  :sort_keys => true,
  :plain     => true
}

YAML.add_domain_type('', 'Ref') { |type, val| { 'Ref' => val } }

YAML.add_domain_type('', 'GetAtt') do |type, val|
  if val.is_a? String
    val = val.split('.')
  end
  { 'Fn::GetAtt' => val }
end

%w(Join Base64 Sub Cidr Split Select ImportValue GetAZs FindInMap And Or If Not).each do |function_name|
  YAML.add_domain_type('', function_name) { |type, val| { "Fn::#{function_name}" => val } }
end