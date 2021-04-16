module Codelog
  module Command
    class Pending
      RELEASES_PATH = 'changelogs/releases'.freeze

      def self.run(title)
        Codelog::Command::Pending.new.run title
      end

      def run(title)
        outputter = Codelog::Output::ReleaseFile.new("#{RELEASES_PATH}/pending.md")
        Codelog::Command::Step::Version.run title,
                                            Date.today.strftime(Codelog::Config.date_input_format),
                                            outputter
        Codelog::Command::Step::Changelog.run
        puts "\n== Pending changes added to changelog =="
      end
    end
  end
end
