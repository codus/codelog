module Codelog
  module Presenter
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
        non_modification_keys = ['Version', 'Date']
        @changes.reject { |key| non_modification_keys.include?(key) }
      end
    end
  end
end
