require 'json'
require 'rspec'
require 'cfn2dsl'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random
end
