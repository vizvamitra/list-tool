# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'list_tool/version'

Gem::Specification.new do |spec|
  spec.name          = "list-tool"
  spec.version       = ListTool::VERSION
  spec.date          = '2014-06-08'
  spec.authors       = ["Dmitrii Krasnov"]
  spec.email         = ["vizvamitra@gmail.com"]
  spec.summary       = "list-tool-#{ListTool::VERSION}"
  spec.description   = "A tool to manage lists of strings (like todos) in your app or terminal"
  spec.homepage      = "http://github.com/vizvamitra/list-tool"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  # spec.add_runtime_dependency "json", '~> 1.8'
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard", "~> 2.6"
  spec.add_development_dependency "guard-rspec", "~> 4.2"
  spec.add_development_dependency "rb-readline", "~> 0.5"
end