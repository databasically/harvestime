# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harvestime/version'

Gem::Specification.new do |spec|
  spec.name          = "harvestime"
  spec.version       = Harvestime::VERSION
  spec.authors       = ["Nick Fausnight"]
  spec.email         = ["nick.s.fausnight@gmail.com"]
  spec.description   = %q{For streamlining and automating time and invoice management in Harvest.}
  spec.summary       = %q{Streamline. Automate. Harvest.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "harvested"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency 'guard-rubocop'
end
