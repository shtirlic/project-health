# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'project-health/version'

Gem::Specification.new do |gem|
  gem.name          = "project-health"
  gem.version       = ProjectHealth::VERSION
  gem.authors       = ["Serg Podtynnyi"]
  gem.email         = ["serg@podtynnyi.com"]
  gem.description   = %q{Library for calculating project health report and analysis based on GitHub Activity data}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/shtirlic/project-health"

  gem.add_dependency "octokit", "~> 1.0"
  gem.add_dependency "activesupport", "~> 3.2.8"
  gem.add_dependency "hirb", "~> 0.7"

  gem.executables   = "project-health"
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
