module Codelog
  module Command
    class Pending
      def self.run(title)
        Codelog::Command::Pending.new.run title
      end

      def run(title)
        outputter = Codelog::Output::ReleaseFile.new(Codelog::Config.pending_filename)
        Codelog::Command::Step::Version.run title, Date.today.strftime(Codelog::Config.date_input_format), outputter
        puts "\n== Pending Changelog updated =="
      end
    end
  end
end
