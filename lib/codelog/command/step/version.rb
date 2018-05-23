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

        def initialize(version, release_date, options = {})
          abort(Codelog::Message::Error.missing_config_file) unless config_file_exists?
          @version = version
          @release_date = Date.strptime(release_date, Codelog::Config.date_input_format).to_s
          @options = options
        rescue ArgumentError
          abort(Codelog::Message::Error.invalid_date_format)
        end

        def self.run(version, release_date, options = {})
          Codelog::Command::Step::Version.new(version, release_date, options).run
        end

        def run
          abort(Codelog::Message::Error.missing_version_number) if @version.nil?
          abort(Codelog::Message::Error.already_existing_version(@version)) if version_exists?
          abort(Codelog::Message::Error.no_detected_changes(@version)) unless unreleased_changes?

          choose_output
        end

        private

        def choose_output
          if @options[:preview]
            print_version_changelog
          else
            save_version_changelog
          end
        end

        def changes_hash
          change_files_paths = Dir["#{UNRELEASED_LOGS_PATH}/*.yml"]
          change_files_paths.inject({}) do |all_changes, change_file|
            changes_per_category = YAML.load_file(change_file)
            all_changes.merge!(changes_per_category) do |category, changes, changes_to_be_added|
              changes | changes_to_be_added
            end
          end
        rescue Psych::SyntaxError => error
          abort(Codelog::Message::Error.could_not_parse_yaml(error))
        end

        def add_entry(line, changes, level = 0)
          if changes.is_a?(Hash)
            changes.each do |key, values|
              line.puts "#{"\t" * level}- #{key}"
              add_entry(line, values, level + 1)
            end
          elsif changes.is_a?(Array)
            changes.each { |change| add_entry(line, change, level) }
          else
            line.puts "#{"\t" * level}- #{changes}"
          end
        end

        def save_version_changelog
          chdir Dir.pwd do
            File.open("#{RELEASES_PATH}/#{@version}.md", 'a') do |line|
              line.puts generate_file_content_from(changes_hash)
            end
          end
        end

        def print_version_changelog
          IO.popen('less', 'w') { |output| output.puts generate_file_content_from(changes_hash) }
        end

        def generate_file_content_from(changes_hash)
          content = StringIO.new
          content.puts "## #{Codelog::Config.version_tag(@version, @release_date)}"
          changes_hash.each do |category, changes|
            content.puts "### #{category}"
            add_entry(content, changes)
            content.puts "\n"
          end
          content.puts "---\n"
          content.string
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
