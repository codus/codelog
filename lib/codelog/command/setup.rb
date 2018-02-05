require 'fileutils'

module Codelog
  module Command
    class Setup
      include FileUtils

      RELEASE_TEMPLATE_FILE_PATH = File.dirname(__FILE__)
                                       .concat('/../../fixtures/release_template.yml')
      CONFIG_FILE_PATH = File.dirname(__FILE__).concat('/../../fixtures/codelog.yml')
      CHANGELOG_TEMPLATE_FILE_PATH = File.dirname(__FILE__)
                                         .concat('/../../fixtures/changelog_template.md.erb')

      CHANGELOG_DEFAULT_PATH = 'CHANGELOG.md'.freeze
      CHANGELOG_DESTINATION_PATH = 'changelogs/releases/changelog-backup.md'.freeze

      def self.run
        Codelog::Command::Setup.new.run
      end

      def run
        chdir Dir.pwd do
          # This script provides the initial setup for the gem usage.
          puts '== Creating folder structure and template =='
          create_folder_structure
          puts '== Copying fixtures =='
          copy_fixtures
          handle_existing_changelog
        end
      end

      private

      def create_folder_structure
        system! 'mkdir changelogs/'
        system! 'mkdir changelogs/unreleased'
        system! 'mkdir changelogs/releases'
        system! 'touch changelogs/unreleased/.gitkeep'
        system! 'touch changelogs/releases/.gitkeep'
      end

      def copy_fixtures
        system! "cp #{RELEASE_TEMPLATE_FILE_PATH} changelogs/release_template.yml"
        system! "cp #{CONFIG_FILE_PATH} changelogs/codelog.yml"
        system! "cp #{CHANGELOG_TEMPLATE_FILE_PATH} changelogs/changelog_template.md.erb"
      end

      def handle_existing_changelog
        return unless old_changelog_exists?
        puts '== Copying existing changelog to releases folder =='
        copy_and_mark_changelog
      end

      def old_changelog_exists?
        File.file?(CHANGELOG_DEFAULT_PATH)
      end

      def copy_and_mark_changelog
        File.open(CHANGELOG_DEFAULT_PATH, 'rb') do |orig|
          File.open(CHANGELOG_DESTINATION_PATH, 'wb') do |dest|
            dest.write("<!-- Old changelog starts here -->\n\n")
            dest.write(orig.read)
          end
        end
      end

      def system!(*args)
        system(*args) || puts("\n== Command #{args} was skipped ==")
      end

      def yes?(args)
        puts(args)
        receive
      end

      def receive(stdin: $stdin)
        stdin.gets.chomp.casecmp('y').zero?
      end
    end
  end
end
