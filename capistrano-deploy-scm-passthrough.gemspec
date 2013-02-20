# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "capistrano-deploy-scm-passthrough"
  gem.version       = "0.1.1"
  gem.authors       = ["Simo Kinnunen"]
  gem.email         = ["simo@shoqolate.com"]
  gem.homepage      = "https://github.com/sorccu/capistrano-deploy-scm-passthrough"
  gem.summary       = %q{Passthrough SCM for Capistrano.}
  gem.description   = %q{Provides a simple :passthrough SCM implementation for Capistrano. Like :none, but more compatible and never copies or modifies any files.}

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('capistrano', '>=2.1.0')
end
