require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

desc "Run all tests by default"
task :default => [:spec]

Spec::Rake::SpecTask.new do |t|
  
end

namespace :spec do
  Spec::Rake::SpecTask.new do |t|
    t.rcov = true
    t.rcov_opts = ['--exclude', 'lib,lib\/spec,bin\/spec']
  end

  RCov::VerifyTask.new do |t|
    t.threshold = 100
  end

  desc "Calculate and verify test coverage"
  task :rcov => [:spec, :verify_rcov]
end

