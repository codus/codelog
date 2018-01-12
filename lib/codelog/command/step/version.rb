require 'yaml'
require 'fileutils'

module Codelog
  module Command
    module Step
      class Version
        include FileUtils

        def initialize(version)
          @version = version
        end

        def self.run(version)
          Codelog::Command::Step::Version.new(version).run
        end

        def run
          abort('ERROR: Please enter a version number') if @version.nil?
          chdir Dir.pwd do
            create_version_changelog_from changes_hash
          end
        end

        private

        def changes_hash
          change_files_paths = Dir['changelogs/unreleased/*.yml']
          change_files_paths.inject({}) do |all_changes, change_file|
            changes_per_category = YAML.load_file(change_file)
            all_changes.merge!(changes_per_category) do |category, changes, changes_to_be_added|
              changes | changes_to_be_added
            end
          end
        end

        def create_version_changelog_from(changes_hash)
          File.open("changelogs/releases/#{@version}.md", 'a') do |line|
            line.puts "## #{@version}"
            changes_hash.each do |category, changes|
              line.puts "### #{category}"
              changes.each { |change| line.puts "- #{change}" }
              line.puts "\n"
            end
            line.puts "---\n"
          end
        end
      end
    end
  end
end
