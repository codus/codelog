require 'fileutils'

module Codelog
  module Command
    class Setup
      include FileUtils

      TEMPLATE_FILE_PATH = File.dirname(__FILE__).concat('/../../fixtures/template.yml')
      CONFIG_FILE_PATH = File.dirname(__FILE__).concat('/../../fixtures/codelog.yml')
      HEADER_FILE_PATH =File.dirname(__FILE__).concat('/../../fixtures/header.txt')

      CHANGELOG_DEFAULT_PATH = 'CHANGELOG.md'.freeze
      CHANGELOG_DESTINATION_PATH = 'changelogs/releases/0.0.0.md'.freeze

      def self.run
        Codelog::Command::Setup.new.run
      end

      def run
        chdir Dir.pwd do
          # This script provides the initial setup for the gem usage.
          handle_existing_changelog
          puts '== Creating folder structure and template =='
          system! 'mkdir changelogs/'
          system! 'mkdir changelogs/unreleased'
          system! 'mkdir changelogs/releases'
          system! "cp #{TEMPLATE_FILE_PATH} changelogs/template.yml"
          system! "cp #{CONFIG_FILE_PATH} changelogs/codelog.yml"
          system! "cp #{HEADER_FILE_PATH} changelogs/header.txt"
          system! 'touch changelogs/unreleased/.gitkeep'
          system! 'touch changelogs/releases/.gitkeep'
        end
      end

      private

      def handle_existing_changelog
        if old_changelog_exists?
          if yes? Codelog::Message::Warning.mantain_versioning_of_existing_changelog?
            puts '== Copying existing changelog to releases folder =='
            copy_and_mark_changelog
          elsif yes? Codelog::Message::Warning.delete_existing_changelog?
            puts '== Deleting existing changelog =='
            system! "rm #{CHANGELOG_DEFAULT_PATH}"
          end
        end
      end

      def old_changelog_exists?
        File.file?(CHANGELOG_DEFAULT_PATH)
      end

      def copy_and_mark_changelog
        File.open(CHANGELOG_DEFAULT_PATH, 'rb') do |orig|
          File.open(CHANGELOG_DESTINATION_PATH, 'wb') do |dest|
            dest.write("#-- Old changelog starts here --\n\n")
            dest.write(orig.read)
          end
        end
      end

      def system!(*args)
        system(*args) || abort("\n== Command #{args} failed ==")
      end

      def yes?(args)
        puts(args)
        receive
      end

      def receive(stdin: $stdin)
        stdin.gets.casecmp('y') == 0
      end
    end
  end
end
