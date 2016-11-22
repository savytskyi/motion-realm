# -*- encoding: utf-8 -*-
VERSION = "1.1.0"

Gem::Specification.new do |spec|
  spec.name          = "motion-realm"
  spec.version       = VERSION
  spec.authors       = ["Kyrylo Savytskyi"]
  spec.email         = ["mail@savytskyi.com"]
  spec.description   = "Realm for Rubymotion"
  spec.summary       = "Realm for Rubymotion"
  spec.homepage      = "https://github.com/savytskyi/motion-realm"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
