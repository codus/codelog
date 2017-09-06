# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "changelog/version"

Gem::Specification.new do |spec|
  spec.name          = "changelog"
  spec.version       = Changelog::VERSION
  spec.authors       = ["Luís Bevilacqua"]
  spec.email         = ["luis.bevilacqua@codus.com.br"]

  spec.summary       = 'A gem to help with changelog management'
  spec.description   = 'A simple gem made to help managing changelogs avoiding conflicts and missplaced changes'

  spec.executables   = ['changelog_setup', 'create_change_file', 'create_version_changelog', 'generate_changelog', 'remove_change_files', 'create_full_changelog']
  spec.require_paths = ["lib"]
  spec.post_install_message = 'To start using the changelog run `changelog_setup` and fill the `template.yml` file'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
