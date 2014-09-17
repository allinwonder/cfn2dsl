Gem::Specification.new do |s|
  s.name = 'cfn2dsl'
  s.version = '0.0.0'
  s.date = '2014-09-15'
  s.summary = "This is a tool to translate CloudFormation JSON template into a Ruby DSL cfndsl"
  s.description = s.summary
  s.files = ['lib/cfn2dsl.rb', 'bin/cfn2dsl']
  s.bindir = 'bin'
  s.executables << 'cfn2dsl'
  s.homepage = 'https://github.com/realestate-com-au/cfn2dsl.git'
  s.authors = 'kevin yung (kevin.yung@rea-group.com)'
  s.required_ruby_version = '>= 2.0.0'
end
