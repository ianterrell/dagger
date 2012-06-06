# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dagger/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ian Terrell"]
  gem.email         = ["ian.terrell@gmail.com"]
  gem.description   = "2D game engine built with GLKit and RubyMotion"
  gem.summary       = "2D game engine for RubyMotion"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dagger"
  gem.require_paths = ["lib"]
  gem.version       = Dagger::VERSION
end