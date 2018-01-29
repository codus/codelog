require 'date'

module Codelog
  class Config
    CONFIG_FILE_PATH = 'changelogs/codelog.yml'.freeze

    class << self
      def filename
        settings['default_changelog_filename'] || 'CHANGELOG.md'
      end

      def header
        File.open(settings['header_textfile'], 'r').read || ''
      end

      def date_input_format
        settings['date_input_format'] || '%Y-%m-%d'
      end

      def version_tag(version)
        "#{version_prefix}#{version}#{version_suffix}"
      end

      private

      def date_output_format
        settings['date_output_format'] || '%Y-%m-%d'
      end

      def version_prefix
        settings['version_prefix'] || ''
      end

      def version_suffix
        settings['version_suffix'] || ''
      end

      def date_prefix
        settings['date_prefix'] || ''
      end

      def show_date?
        settings['show_date']
      end

      def settings
        @settings ||= YAML.load_file(CONFIG_FILE_PATH)
      end
    end
  end
end
