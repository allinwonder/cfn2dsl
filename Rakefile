namespace :cfn2dsl do
  task :build do
    `gem build cfn2dsl.gemspec`
  end

  task :install do
  end
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => [:spec]
