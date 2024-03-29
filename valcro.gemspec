$:.push File.expand_path("../lib", __FILE__)
require "valcro/version"

Gem::Specification.new do |s|
  s.name = "valcro"
  s.version = Valcro::VERSION
  s.authors = ["Harold Giménez"]
  s.email = ["harold.gimenez@gmail.com"]
  s.homepage = "https://github.com/hgmnz/valcro"
  s.summary = "The simplest possible validation library for Ruby"
  s.description = "Valcro is a validation library for arbitrary ruby objects. I's primary goal is to remain as simple as possible so that it can be useful to a large surface of use cases remaining easily extensible."

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-collection_matchers"
  s.add_development_dependency "rake"
  s.add_development_dependency "standardrb"
end
