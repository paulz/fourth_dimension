require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

desc "Run all tests by default"
task :default => [:spec]

Spec::Rake::SpecTask.new

namespace :spec do
  Spec::Rake::SpecTask.new do |t|
    t.rcov = true
    t.rcov_opts = ['--exclude', '\/gems,lib\/spec,bin\/spec']
  end

  RCov::VerifyTask.new(:verify_coverage) do |t|
    t.threshold = 100
  end

  desc "Run specs and verify test coverage"
  task :rcov => [:spec, :verify_coverage]
end

