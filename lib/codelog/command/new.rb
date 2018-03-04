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

          @file_name = "changelogs/unreleased/#{Time.now.strftime('%Y%m%d%H%M%S%L')}_change.yml"
          if options[:interactive]
            build_from_hash Codelog::CLIs::Interactive.new.ask_for_changes
          else
            build_from_template
          end
          system! "#{default_editor} #{@file_name}" if options[:edit]
        end
      end

      private

      def build_from_template
        puts "== Creating #{@file_name} change file based on example =="
        system! "cp changelogs/template.yml #{@file_name}"
      end

      def build_from_hash(changes_hash)
        puts "== Creating #{@file_name} change file from the provided changes =="
        File.open(@file_name, 'a') do |file|
          file.puts changes_hash.to_yaml
        end
      end

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
