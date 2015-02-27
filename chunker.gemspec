# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chunker/version'

Gem::Specification.new do |spec|
  spec.name          = "chunker"
  spec.version       = Chunker::VERSION
  spec.authors       = ["Haris Dimitriou (xarisd)"]
  spec.email         = ["xaris.dimitriou@gmail.com"]
  spec.summary       = %q{A small utility that reads and writes files in chunks}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra", "~> 1.4.5"
  spec.add_dependency "json", "~> 1.8.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "cucumber", "~> 1.3"
  spec.add_development_dependency "json_spec"
end
