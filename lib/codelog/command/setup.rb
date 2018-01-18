require 'fileutils'

module Codelog
  module Command
    class Setup
      include FileUtils

      TEMPLATE_FILE_PATH = File.dirname(__FILE__).concat('/../../fixtures/template.yml')
      CONFIG_FILE_PATH = File.dirname(__FILE__).concat('/../../fixtures/codelog.yml')

      def self.run
        Codelog::Command::Setup.new.run
      end

      def run
        chdir Dir.pwd do
          # This script provides the initial setup for the gem usage.

          puts '== Creating folder structure and template =='
          system! 'mkdir changelogs/'
          system! 'mkdir changelogs/unreleased'
          system! 'mkdir changelogs/releases'
          system! "cp #{TEMPLATE_FILE_PATH} changelogs/template.yml"
          system! "cp #{TEMPLATE_FILE_PATH} changelogs/codelog.yml"
          system! 'touch changelogs/unreleased/.gitkeep'
          system! 'touch changelogs/releases/.gitkeep'
        end
      end

      private

      def system!(*args)
        system(*args) || abort("\n== Command #{args} failed ==")
      end
    end
  end
end
