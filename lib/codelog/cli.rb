require 'thor'
require 'date'
require 'yaml'

module Codelog
  class CLI < Thor
    map ['--version', '-v'] => :__print_version

    desc '[--version, -v]', 'prints current codelog version'
    def __print_version
      puts "Codelog version #{Codelog::VERSION}"
    end

    desc 'setup', 'Generate the changelogs folder structure and the template.yml file'
    def setup
      Codelog::Command::Setup.run
    end

    desc 'new <NAME>', 'Generate a file from the template for the unreleased changes'
    method_option :edit, desc: 'Opens the default system editor after creating a changefile',
                         aliases: '-e', type: :boolean
    method_option :interactive, desc: 'Add contents interactively to change file',
                                aliases: '-i', type: :boolean
    def new(name = 'change')
      Codelog::Command::New.run name, options
    end

    desc 'release [VERSION] <RELEASE_DATE>', 'Generate new release updating changelog'
    method_option :preview, desc: 'Prints the preview of the specified version release',
                            aliases: ['-p', '--preview'], type: :boolean
    def release(version_number,
                release_date = Date.today.strftime(Codelog::Config.date_input_format))
      if options[:preview]
        Codelog::Command::Preview.run version_number, release_date
      else
        Codelog::Command::Release.run version_number, release_date
      end
    end

    desc 'bump [VERSION_TYPE] <RELEASE_DATE>', 'Bumps the next version,
     being it major, minor or patch'
    method_option :preview, desc: 'Prints the preview of the next version',
                            aliases: ['-p', '--preview'], type: :boolean
    def bump(version_type, release_date =
                Date.today.strftime(Codelog::Config.date_input_format))
      Codelog::Command::Bump.run version_type, release_date, options
    end
  end
end
