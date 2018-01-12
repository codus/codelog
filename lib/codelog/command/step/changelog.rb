require 'fileutils'

module Codelog
  module Command
    module Step
      class Changelog
        include FileUtils

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
          version_changelogs = Dir['changelogs/releases/*.md']
          version_changelogs.sort_by! do |file_name|
            version_number = file_name.split('/').last.chomp('.md')
            Gem::Version.new(version_number)
          end.reverse!
          version_changelogs.inject([]) do |partial_changes, version_changelog|
            partial_changes + File.readlines(version_changelog)
          end
        end

        def create_file_from(changes)
          File.open('CHANGELOG.md', 'w+') do |f|
            f.puts %(# Changelog
  All notable changes to this project will be documented in this file.
  The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
  and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).
            )
            f.puts(changes)
          end
        end
      end
    end
  end
end
