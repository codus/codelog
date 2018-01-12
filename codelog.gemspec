# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "codelog/version"

Gem::Specification.new do |spec|
  spec.name          = "codelog"
  spec.version       = Codelog::VERSION
  spec.authors       = ["Luís Bevilacqua"]
  spec.email         = ["luis.bevilacqua@codus.com.br"]

  spec.summary       = 'A gem to help with changelog management'
  spec.description   = 'A simple gem made to help managing changelogs avoiding conflicts and missplaced changes'

  spec.executables   = ['codelog']
  spec.require_paths = ["lib"]
  spec.post_install_message = 'To start using the changelog run `codelog setup` and fill the `template.yml` file'

  spec.add_runtime_dependency "thor", "~> 0.20.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "rubocop", "~> 0.52.1"
  spec.add_development_dependency "simplecov"
end
