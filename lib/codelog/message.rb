module Codelog
  class Message
    class Error
      class << self
        def prefix
          'ERROR'
        end

        def missing_version_number
          "#{prefix}: Please enter a version number"
        end

        def invalid_date_format
          "#{prefix}: Invalid date format. Check the input date format on:\n\n" \
          'changelogs/codelog.yml'
        end

        def already_existing_version(version)
          "#{prefix}: Could not create release #{version}. Release #{version} already exists"
        end

        def no_detected_changes(version)
          "#{prefix}: Could not create release #{version}. You must create a change first.\n" \
          "Run the following command to create a new change file:\n\n" \
          "codelog new\n\n" \
          "Then describe your changes on the file generated at:\n\n" \
          'changelog/unreleased'
        end
      end
    end
  end
end
