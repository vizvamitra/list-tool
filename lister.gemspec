# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lister/version'

Gem::Specification.new do |spec|
  spec.name          = "lister"
  spec.version       = Lister::VERSION
  spec.authors       = ["Vizvamitra"]
  spec.email         = ["vizvamitra@gmail.com"]
  spec.summary       = "A class to manage lists (like to-do list) in your app or unix console"
  spec.description   = "Will write it later"
  spec.homepage      = "http://github.com/vizvamitra/lister"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.3.1"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "guard", "~> 2.6.0"
  spec.add_development_dependency "guard-rspec", "~> 4.2.8"
  spec.add_development_dependency "rb-readline", "~> 0.5.1"
end