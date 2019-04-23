module Codelog
  module Command
    class Regenerate
      def self.run
        Codelog::Command::Regenerate.new.run
      end

      def run
        Codelog::Command::Step::Changelog.run
      end
    end
  end
end
