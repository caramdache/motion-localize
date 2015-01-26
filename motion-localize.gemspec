# -*- encoding: utf-8 -*-
VERSION = "1.0.0"

Gem::Specification.new do |spec|
  spec.name          = "motion-localize"
  spec.version       = VERSION
  spec.authors       = ["Caram"]
  spec.email         = ["caramdache@gmail.com"]
  spec.description   = %q{This is RubyMotion plugin which provides commands to perform automatic localization.}
  spec.summary       = %q{This is RubyMotion plugin which provides commands to perform automatic localization.}
  spec.homepage      = "https://github.com/caramdache/motion-localize"
  spec.license       = "MIT"
  spec.extensions    = ['ext/extconf.rb'] # Command-Line Plugin Installer

  files = []
  files << 'README.md'
  files.concat(Dir.glob('ext/**/*'))
  files.concat(Dir.glob('command/**/*.rb'))
  spec.files         = files
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'motion-appstore', '~> 1.0'
end
