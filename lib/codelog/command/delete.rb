require 'fileutils'

module Codelog
  module Command
    class Delete
      include FileUtils

      def self.run
        Codelog::Command::Delete.new.run
      end

      def run
        chdir Dir.pwd do
          system('rm -rv changelogs/unreleased/*.yml')
        end
      end
    end
  end
end
