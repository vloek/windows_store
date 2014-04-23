# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'windows_store/version'

Gem::Specification.new do |spec|
  spec.name          = "windows_store"
  spec.version       = WindowsStore::VERSION
  spec.authors       = ["Lex"]
  spec.email         = ["lex.antonov@gmail.com"]
  spec.summary       = %q{Windows Store receipt verification.}
  spec.description   = %q{Windows Store receipt verification.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"

  spec.add_dependency 'rest_client'
  spec.add_dependency 'xmldsig'
  spec.add_dependency 'json'
end
