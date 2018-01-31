require 'fileutils'
require 'yaml'
require 'ostruct'
require 'erb'

module Codelog
  module Command
    module Step
      class Changelog
        include FileUtils

        ERB_TEMPLATE_PATH = 'changelogs/changelog_template.md.erb'.freeze

        def self.run
          Codelog::Command::Step::Changelog.new.run
        end

        def run
          chdir Dir.pwd do
            create_file_from changes
          end
        end

        private

        def changes
          releases_files_paths = Dir['changelogs/releases/*.yml']
          releases_files_paths.sort_by! do |file_name|
            version_number = file_name.split('/').last.chomp('.md')
            Gem::Version.new(version_number)
          end.reverse!
          partial_changes = []
          releases_files_paths.each do |version_changelog|
            partial_changes << YAML.load_file(version_changelog)
          end
          partial_changes
        end

        def create_file_from(changes)
          template = File.read(ERB_TEMPLATE_PATH)
          final_changelog = ERB.new(template).result binding
          # Removes spaces from the start of all lines
          File.open(Codelog::Config.filename, 'w+') do |f|
            f.puts(final_changelog)
          end
        end
      end
    end
  end
end
