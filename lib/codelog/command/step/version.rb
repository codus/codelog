require 'date'
require 'yaml'
require 'fileutils'

module Codelog
  module Command
    module Step
      class Version
        include FileUtils

        RELEASES_PATH = 'changelogs/releases'.freeze
        UNRELEASED_LOGS_PATH = 'changelogs/unreleased'.freeze
        CONFIG_FILE_PATH = 'changelogs/codelog.yml'.freeze

        def initialize(version, release_date)
          abort(Codelog::Message::Error.missing_config_file) unless config_file_exists?
          @version = version
          @release_date = Date.strptime(release_date, Codelog::Config.date_input_format).to_s
        rescue ArgumentError
          abort(Codelog::Message::Error.invalid_date_format)
        end

        def self.run(version, release_date)
          Codelog::Command::Step::Version.new(version, release_date).run
        end

        def run
          abort(Codelog::Message::Error.missing_version_number) if @version.nil?
          abort(Codelog::Message::Error.already_existing_version(@version)) if version_exists?
          abort(Codelog::Message::Error.no_detected_changes(@version)) unless unreleased_changes?
          chdir Dir.pwd do
            create_version_changelog_from changes_hash
          end
        end

        private

        def changes_hash
          change_files_paths = Dir["#{UNRELEASED_LOGS_PATH}/*.yml"]
          change_files_paths.inject({}) do |all_changes, change_file|
            changes_per_category = YAML.load_file(change_file)
            all_changes.merge!(changes_per_category) do |category, changes, changes_to_be_added|
              changes | changes_to_be_added
            end
          end
        end

        def create_version_changelog_from(changes_hash)
          File.open("#{RELEASES_PATH}/#{@version}.md", 'a') do |line|
            line.puts "## #{Codelog::Config.version_tag(@version, @release_date)}"
            changes_hash.each do |category, changes|
              line.puts "### #{category}"
              changes.each { |change| line.puts "- #{change}" }
              line.puts "\n"
            end
            line.puts "---\n"
          end
        end

        def version_exists?
          File.file?("#{RELEASES_PATH}/#{@version}.md")
        end

        def unreleased_changes?
          Dir["#{UNRELEASED_LOGS_PATH}/*.yml"].any?
        end

        def config_file_exists?
          File.file?(CONFIG_FILE_PATH)
        end
      end
    end
  end
end
