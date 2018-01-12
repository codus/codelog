module Codelog
  module Command
    class Release
      def self.run(version_number)
        Codelog::Command::Release.new.run version_number
      end

      def run(version_number)
        Codelog::Command::Step::Version.run version_number
        Codelog::Command::Step::Delete.run
        Codelog::Command::Step::Changelog.run
      end
    end
  end
end
