# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "codelog/version"

Gem::Specification.new do |spec|
  spec.name          = 'codelog'
  spec.version       = Codelog::VERSION.dup
  spec.authors       = ['Luís Bevilacqua', 'Rodrigo Masaru', 'Fernanda Thomazinho', 'Celso Crivelaro', 'Vinicius Oyama']
  spec.email         = ['opensource@codus.com.br']

  spec.summary       = 'A gem to help with changelog management'
  spec.description   = 'A simple to use gem made to help managing changelogs avoiding conflicts and missplaced changes'
  spec.license       = 'MIT'
  spec.homepage      = 'https://github.com/codus/codelog'
  spec.files         = Dir.glob("{bin,lib}/**/*") + %w(CHANGELOG.md CODE_OF_CONDUCT.md CONTRIBUTING.md LICENSE Rakefile README.md)

  spec.executables   = ['codelog']
  spec.require_paths = ['lib']
  spec.post_install_message = 'To start using the codelog run `codelog setup` and fill the `template.yml` file'
  spec.required_ruby_version = ">= 2.1.10"

  spec.add_runtime_dependency "thor", "~> 0.19"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "rubocop", "~> 0.52.1"
  spec.add_development_dependency "simplecov"
end
