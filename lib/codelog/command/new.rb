require 'fileutils'

module Codelog
  module Command
    class New
      include FileUtils

      def self.run
        Codelog::Command::New.new.run
      end

      def run
        chdir Dir.pwd do
          # This script create a change file for the changelog documentation.

          full_file_name = "changelogs/unreleased/#{Time.now.strftime('%Y%m%d%H%M%S%L')}_change.yml"

          puts "== Creating #{full_file_name} change file based on example =="
          system! "cp changelogs/release_template.yml #{full_file_name}"
        end
      end

      private

      def system!(*args)
        system(*args) || abort("\n== Command #{args} failed ==")
      end
    end
  end
end
