module Codelog
  module Command
    class Bump
      CODELOG_RELEASES_PATH = 'changelogs/releases/'.freeze
      def self.run(version_type, release_date)
        Codelog::Command::Bump.new.run version_type, release_date
      end

      def run(version_type, release_date)
        abort(Codelog::Message::Error.invalid_version_type(version_type)) unless %w(major minor patch).include? version_type
        Codelog::Command::Release.run next_version(version_type), release_date
      end

      private

      def next_version(version_type)
        last_version = last_created_changelog.split('.').map { |version| version.to_i }
        case version_type
        when 'major'
          last_version[0] += 1
          last_version[1] = 0
          last_version[2] = 0
        when 'minor'
          last_version[1] += 1
          last_version[0] = 0
        when 'patch'
          last_version[2] += 1
        end
        next_version = last_version.join('.')
      end

      def last_created_changelog
        Dir.glob(File.join(CODELOG_RELEASES_PATH, '*.md*')).max_by { |file| Gem::Version.new(file.gsub!(CODELOG_RELEASES_PATH, '').gsub!('.md', '')) }
      end
    end
  end
end
