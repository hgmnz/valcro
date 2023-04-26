require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)
task default: :spec

namespace :gem do
  desc "Release to rubygems"
  task :release do
    require File.expand_path("lib/valcro/version", File.dirname(__FILE__))
    version = Valcro::VERSION
    message = "Bump to version #{version}"
    system "git tag -a -m '#{message}' v#{version}"
    system "git push origin master"
    system "git push origin $(git tag | tail -1)"
    system "gem build valcro.gemspec"
    system "gem push valcro-#{version}.gem"
    system "rm valcro-#{version}.gem"
  end
end
