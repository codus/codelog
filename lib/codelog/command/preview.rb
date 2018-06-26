module Codelog
  module Command
    class Preview
      def self.run(version_number, release_date)
        Codelog::Command::Preview.new.run version_number, release_date
      end

      def run(version_number, release_date)
        outputter = Codelog::Output::Log.new
        Codelog::Command::Step::Version.run version_number, release_date, outputter
      end
    end
  end
end
