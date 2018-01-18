require 'thor'
require 'date'

module Codelog
  class CLI < Thor
    desc 'setup', 'Generate the changelogs folder structure and the template.yml file'
    def setup
      Codelog::Command::Setup.run
    end

    desc 'new', 'Generate a file from the template for the unreleased changes'
    def new
      Codelog::Command::New.run
    end

    desc 'release [VERSION] <RELEASE_DATE>', 'Generate new release updating changelog'
    def release(version_number, release_date = Date.today.to_s)
      Codelog::Command::Release.run version_number, release_date
    end
  end
end
