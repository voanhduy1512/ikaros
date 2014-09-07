# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ikaros/version'

Gem::Specification.new do |spec|
  spec.name          = "ikaros"
  spec.version       = Ikaros::VERSION
  spec.authors       = ["Võ Anh Duy"]
  spec.email         = ["voanhduy1512@live.com"]
  spec.summary       = "update later"
  spec.description   = "update later"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['ikaros']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.1.0'
  spec.add_development_dependency 'guard', '~> 2.6.1'
  spec.add_development_dependency 'guard-rspec', '~> 4.3.1'
  spec.add_development_dependency 'pry'

  spec.add_runtime_dependency 'thor', '~> 0.19.1'
end
