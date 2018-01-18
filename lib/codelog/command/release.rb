module Codelog
  module Command
    class Release
      def self.run(version_number, release_date)
        Codelog::Command::Release.new.run version_number, release_date
      end

      def run(version_number, release_date)
        Codelog::Command::Step::Version.run version_number, release_date
        Codelog::Command::Step::Delete.run
        Codelog::Command::Step::Changelog.run
      end
    end
  end
end
