lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redshift/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "redshift-rails"
  spec.version       = Redshift::Rails::VERSION
  spec.authors       = ["Dai Akatsuka"]
  spec.email         = ["d.akatsuka@gmail.com"]

  spec.summary       = %q{The library provides the railtie that allows redshift-client into Rails.}
  spec.description   = %q{The library provides the railtie that allows redshift-client into Rails.}
  spec.homepage      = "https://github.com/dakatsuka/redshift-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "redshift-client", "~> 0.2"
  spec.add_runtime_dependency "railties", ">= 4"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
