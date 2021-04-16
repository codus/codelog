require 'fileutils'

module Codelog
  module Command
    module Step
      class Delete
        include FileUtils

        def self.run
          Codelog::Command::Step::Delete.new.run
        end

        def run
          chdir Dir.pwd do
            system('rm -rv changelogs/unreleased/*.yml')
          end
        end
      end
    end
  end
end
