require 'thor'

module Codelog
  # The Command Line Interface for Codelog
  #
  # See bin/codelog for more information
  class CLI < Thor
    desc 'setup', 'Generate the changelogs folder structure and the template.yml file'
    def setup
      Codelog::Command::Setup.run
    end
  end
end
