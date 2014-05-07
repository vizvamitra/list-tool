# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'list_tool/version'

Gem::Specification.new do |spec|
  spec.name          = "list-tool"
  spec.version       = ListTool::VERSION
  spec.authors       = ["Vizvamitra"]
  spec.email         = ["vizvamitra@gmail.com"]
  spec.summary       = "A tool to manage lists (like to-do list) in your app or unix console"
  spec.description   = "Will write it later"
  spec.homepage      = "http://github.com/vizvamitra/list_tool"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rb-readline"
end