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

    desc 'delete', 'Delete all change files at unreleased folder'
    def delete
      Codelog::Command::Delete.run
    end
  end
end
