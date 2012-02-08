# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "valcro/version"

Gem::Specification.new do |s|
  s.name        = "valcro"
  s.version     = Valcro::VERSION
  s.authors     = ["Harold Giménez"]
  s.email       = ["harold.gimenez@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Validation so simple you probably don't need this}
  s.description = %q{Validation so simple you probably don't need this}

  s.rubyforge_project = "valcro"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
