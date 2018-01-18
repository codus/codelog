module Codelog
  class Config
    CONFIG_FILE_PATH = 'changelogs/codelog.yml'

    class << self
      def filename
        settings['default_filename'] || 'CHANGELOG.md'
      end

      def header
        settings['header_text'] || default_header
      end

      def version_tag version, release_date
        "#{version_prefix}#{version}#{version_suffix} - #{date_prefix}#{release_date}"
      end

      private

      def version_prefix
        settings['version_prefix'] || ""
      end

      def version_suffix
        settings['version_suffix'] || ""
      end

      def date_prefix
        settings['date_prefix'] || ""
      end

      def show_date
        settings['show_date']
      end

      # def date_format
      # end

      def settings
        @settings ||= YAML.load_file(CONFIG_FILE_PATH)
      end

      def default_header
        "All notable changes to this project will be documented in this file." \
        "The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)" \
        "and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).\n"
      end

    end
  end
end