require 'thor'

module Codelog
  module CLIs
    class Interactive < Thor
      include Thor::Actions

      no_commands do
        def initialize
          @sections = YAML.load_file('changelogs/template.yml').keys
        end

        def run
          changes_hash = Hash.new([])
          loop do
            change_category = ask_for_type
            say "\nType the entries for #{set_color(change_category, :yellow)}(ENTER to stop):"
            changes_hash[change_category] += ask_for_changes
            break if no? "\nWould you like to add a new log(Y|N)?"
          end

          changes_hash
        end

        private

        def ask_for_type
          say 'Enter a change type number:'
          @sections.each_with_index do |section, index|
            say "#{index + 1}. #{section}"
          end
          @sections[ask('>').to_i - 1]
        end

        def ask_for_changes(level = 1)
          changes = []
          loop do
            change = ask('>' * level)

            break if change.empty?

            change = { change.chomp(':') => ask_for_changes(level + 1) } if subcategory?(change)

            changes << change
          end

          changes
        end

        def subcategory?(change)
          change.end_with?(':')
        end
      end
    end
  end
end
