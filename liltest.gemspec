# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liltest/version'

Gem::Specification.new do |gem|
  gem.name          = "liltest"
  gem.version       = Liltest::VERSION
  gem.authors       = ["Dennis Schneider"]
  gem.email         = ["sinned.schneider@gmail.com"]
  gem.description   = %q{A small test-framework with Rspec-like syntax}
  gem.summary       = %q{A small test-framework with Rspec-like syntax}
  gem.homepage      = "https://github.com/dschneider/liltest"


  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('typhoeus')
  gem.add_runtime_dependency('json')

  gem.add_development_dependency('rspec')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('simplecov')
  gem.add_development_dependency('travis')
end
