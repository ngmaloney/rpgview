# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rpgview/version'

Gem::Specification.new do |gem|
  gem.name          = "rpgview"
  gem.version       = Rpgview::VERSION
  gem.authors       = ["Nick Maloney"]
  gem.email         = ["ngmaloney@gmail.com"]
  gem.description   = %q{Generates postgresql views with sane table structure from legacy tables.}
  gem.summary       = %q{RPGView is a sql generator for creating a Postgresql view wrapper around a gnarly legacy table. It includes all the Postgresql 9.1 trigger goodness for interacting directly with the view in your Rails app.}
  gem.homepage      = "https://github.com/ngmaloney/rpgview"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('aruba')
  gem.add_development_dependency('rake', '~> 0.9.2')
  gem.add_dependency('methadone', '~> 1.2.3')
end
