module Codelog
  module Presenters
    class VersionDataPresenter
      def initialize(version_changes_data)
        @changes = version_changes_data
      end

      def date
        @changes['Date'].strftime(Codelog::Config.date_output_format)
      end

      def version
        @changes['Version']
      end

      def modifications
        @changes.dup.delete_if { |key| key == 'Version' || key == 'Date' }
      end
    end
  end
end
