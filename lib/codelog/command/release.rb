module Codelog
  module Command
    class Release
      def self.run(version_number, release_date, options)
        Codelog::Command::Release.new.run version_number, release_date, options
      end

      def run(version_number, release_date, options)
        Codelog::Command::Step::Version.run version_number, release_date, options
        unless options[:preview]
          Codelog::Command::Step::Delete.run
          Codelog::Command::Step::Changelog.run
          puts "\n== Changelog updated to version #{version_number} =="
        end
      end
    end
  end
end
