Gem::Specification.new do |s|
  s.name = 'cfn2dsl'
  s.version = '0.1.5'
  s.date = '2014-09-15'
  s.authors = ["Kevin Yung", "Valen Gunawan"]
  s.summary = "A tool to convert CloudFormation JSON template into a Ruby DSL cfndsl"
  s.description = s.summary
  s.license = 'MIT'
  s.files = [
    "lib/cfn2dsl.rb",
    "lib/cfn_parser.rb",
    "lib/cfndsl.erb",
    "lib/cloudformation.rb",
    "lib/condition.rb",
    "lib/intrinsic_function.rb",
    "lib/mapping.rb",
    "lib/output.rb",
    "lib/parameter.rb",
    "lib/render.rb",
    "lib/resource.rb"
  ]
  s.bindir = 'bin'
  s.executables << 'cfn2dsl'
  s.homepage = 'https://github.com/allinwonder/cfn2dsl.git'
  s.authors = 'kevin yung (jwrong@gmail.com)'
  s.required_ruby_version = '>= 2.3.0'
  s.add_dependency('extlib')
  s.add_dependency('awesome_print')
  s.add_dependency('erubis')
end
