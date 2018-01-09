require 'fileutils'

module Codelog
  module Command
    class Setup
      include FileUtils

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
          system! 'touch changelogs/template.yml'
        end
      end

      private

      def system!(*args)
        system(*args) || abort("\n== Command #{args} failed ==")
      end
    end
  end
end
