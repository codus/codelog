require 'fileutils'

module Codelog
  module Command
    class New
      include FileUtils

      def self.run(options)
        Codelog::Command::New.new.run options
      end

      def run(options)
        chdir Dir.pwd do
          # This script create a change file for the changelog documentation.

          full_file_name = "changelogs/unreleased/#{Time.now.strftime('%Y%m%d%H%M%S%L')}_change.yml"

          puts "== Creating #{full_file_name} change file based on example =="
          system! "cp changelogs/template.yml #{full_file_name}"
          system! "#{default_editor} #{full_file_name}" if options[:edit]
        end
      end

      private

      def default_editor
        # Looks for the default editor in VISUAL and EDITOR system variables
        # if no variable is set it defaults to nano

        '${VISUAL:-${EDITOR:-nano}}'
      end

      def system!(*args)
        system(*args) || abort("\n== Command #{args} failed ==")
      end
    end
  end
end
