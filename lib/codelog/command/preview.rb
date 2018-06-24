module Codelog
  module Command
    class Preview
      def self.run(version_number, release_date)
        Codelog::Command::Preview.new.run version_number, release_date
      end

      def run(version_number, release_date)
        content = Codelog::Command::Step::Version.run version_number, release_date
        Codelog::Output::Log.print content
      end
    end
  end
end
