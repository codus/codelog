require 'thor'
require 'date'
require 'yaml'

module Codelog
  class CLI < Thor
    desc 'setup', 'Generate the changelogs folder structure and the template.yml file'
    def setup
      Codelog::Command::Setup.run
    end

    desc 'new <NAME>', 'Generate a file from the template for the unreleased changes'
    method_option :edit, desc: 'Opens the default system editor after creating a changefile',
                         aliases: '-e', type: :boolean
    def new(name = 'change')
      Codelog::Command::New.run name, options
    end

    desc 'release [VERSION] <RELEASE_DATE>', 'Generate new release updating changelog'
    def release(version_number, release_date =
                Date.today.strftime(Codelog::Config.date_input_format))
      Codelog::Command::Release.run version_number, release_date
    end
  end
end
