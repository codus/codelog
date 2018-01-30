require 'fileutils'
require 'yaml'
require 'ostruct'
require 'erb'

module Codelog
  module Command
    module Step
      class Changelog
        include FileUtils

        def self.run
          Codelog::Command::Step::Changelog.new.run
        end

        def run
          chdir Dir.pwd do
            create_file_from changes
          end
        end

        private

        def changes
          releases_files_paths = Dir['changelogs/releases/*.yml']
          releases_files_paths.sort_by! do |file_name|
            version_number = file_name.split('/').last.chomp('.md')
            Gem::Version.new(version_number)
          end.reverse!
          partial_changes = []
          releases_files_paths.each do |version_changelog|
            partial_changes << (YAML.load_file(version_changelog))
          end
          partial_changes
        end



        def create_file_from(changes)
          a = ERB.new("<% changes.each do |version_data| %>
          Versão: <%= version_data['Version'] %>
          Data <%= version_data['Date'].strftime('%d/%m/%Y') %>
          <% version_data.dup.delete_if {|key| key == 'Version' || key == 'Date'}.each do |category, content| %>
          <%= category %>
          <% content.each do |item|%>
          - <%= item %>
          <% end %>
          <% end %>
          <% end %>").result binding
          puts a
        end
      end
    end
  end
end
