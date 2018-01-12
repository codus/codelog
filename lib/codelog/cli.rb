require 'thor'

module Codelog
  class CLI < Thor
    desc 'setup', 'Generate the changelogs folder structure and the template.yml file'
    def setup
      Codelog::Command::Setup.run
    end

    desc 'new', 'Generate a file from the template for the unreleased changes'
    method_option :change, aliases: '-c', default: true, desc: 'Create a change file'
    def new
      Codelog::Command::New.run
    end

    desc 'release [VERSION]', 'Generate new release updating changelog'
    def release(version_number)
      Codelog::Command::Release.run version_number
    end
  end
end
