require 'date'

module Codelog
  class Config
    CONFIG_FILE_PATH = 'changelogs/codelog.yml'.freeze

    class << self
      def filename
        settings['default_changelog_filename'] || 'CHANGELOG.md'
      end

      def pending_changes_title
        settings['default_pending_changes_title'] || 'Pending Changes'
      end

      def header
        File.open(settings['header_textfile'], 'r').read || ''
      end

      def date_input_format
        settings['date_input_format'] || '%Y-%m-%d'
      end

      def version_tag(version, release_date)
        date_suffix =
          if show_date?
            parsed_date = Date.strptime(release_date, '%Y-%m-%d').strftime(date_output_format)
            " - #{date_prefix}#{parsed_date}"
          else
            ''
          end
        "#{version_prefix}#{version}#{version_suffix}#{date_suffix}"
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
