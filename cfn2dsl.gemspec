$LOAD_PATH.unshift(File.dirname(__FILE__) + "/lib")
require "version" 
Gem::Specification.new do |s|
  s.name = 'cfn2dsl'
  s.version = Cfn2dsl::VERSION
  s.date = Time.now().strftime("%Y-%m-%d")
  s.authors = ["Kevin Yung", "Valen Gunawan", "Cam Maxwell"]
  s.summary = "A tool to convert CloudFormation templates into a Ruby DSL cfndsl"
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
    "lib/resource.rb",
    "lib/version.rb",
    "lib/metadata.rb",
    "lib/rules.rb",
    "lib/error.rb",
  ]
  s.bindir = 'bin'
  s.executables << 'cfn2dsl'
  s.homepage = 'https://github.com/allinwonder/cfn2dsl.git'
  s.email = 'jwrong@gmail.com'
  s.required_ruby_version = '>= 2.4.4'
  s.add_dependency('extlib', '0.9.16')
  s.add_dependency('awesome_print', '1.8.0')
  s.add_dependency('erubis', '2.7.0')
end
