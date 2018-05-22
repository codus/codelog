module Codelog
  module Command
    class Release
      def self.run(version_number, release_date, options)
        Codelog::Command::Release.new.run version_number, release_date, options
      end

      def run(version_number, release_date, options)
        Codelog::Command::Step::Version.run version_number, release_date, options
        Codelog::Command::Step::Delete.run unless options[:preview]
        Codelog::Command::Step::Changelog.run unless options[:preview]
        puts "\n== Changelog updated to version #{version_number} ==" unless options[:preview]
      end
    end
  end
end
