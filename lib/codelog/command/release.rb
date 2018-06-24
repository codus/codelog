module Codelog
  module Command
    class Release
      RELEASES_PATH = 'changelogs/releases'.freeze

      def self.run(version_number, release_date)
        Codelog::Command::Release.new.run version_number, release_date
      end

      def run(version_number, release_date)
        outputter = Codelog::Output::ReleaseFile.new("#{RELEASES_PATH}/#{version_number}.md")
        Codelog::Command::Step::Version.run version_number, release_date, outputter
        Codelog::Command::Step::Delete.run
        Codelog::Command::Step::Changelog.run
        puts "\n== Changelog updated to version #{version_number} =="
      end
    end
  end
end
