module Codelog
  module Command
    class Release
      include FileUtils

      RELEASES_PATH = 'changelogs/releases'.freeze

      def self.run(version_number, release_date)
        Codelog::Command::Release.new.run version_number, release_date
      end

      def run(version_number, release_date)
        file_content = Codelog::Command::Step::Version.run version_number, release_date
        next_version_filepath = "#{RELEASES_PATH}/#{version_number}.md"

        Codelog::Output::ReleaseFile.print(file_content, next_version_filepath)
        Codelog::Command::Step::Delete.run
        Codelog::Command::Step::Changelog.run
        puts "\n== Changelog updated to version #{version_number} =="
      end
    end
  end
end
