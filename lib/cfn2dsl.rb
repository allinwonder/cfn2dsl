$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'json'
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

AwesomePrint.defaults = {
  :indent    => -2,
  :index     => false,
  :sort_keys => true,
  :plain     => true
}

VERSION="0.1.5"
