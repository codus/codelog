require 'thor'

module Codelog
  module CLIs
    class Interactive < Thor
      include Thor::Actions

      no_commands do
        def initialize
          @sections = YAML.load_file('changelogs/template.yml').keys
        end

        def ask_for_changes
          change_type = ask_for_type
          say "\nType the entries for \e[33m#{change_type}\e[0m(ENTER to stop):"
          result_hash = { change_type => build_array_response }
          if yes? "\nWould you like to add a new log(Y|N)?"
            result_hash.merge!(ask_for_changes) do |_, changes, changes_to_be_added|
              changes | changes_to_be_added
            end
          end
          result_hash
        end

        private

        def ask_for_type
          say 'Enter a change type number:'
          @sections.each_with_index do |section, index|
            say "#{index + 1}. #{section}"
          end
          @sections[ask('>').to_i - 1]
        end

        def build_array_response(level = 1)
          response = ask('>' * level)
          if response.empty?
            []
          else
            processed_response(response, level) | build_array_response(level)
          end
        end

        def processed_response(response, level)
          if response =~ /:$/
            [{ response.gsub(/:$/, '') => build_array_response(level + 1) }]
          else
            [response]
          end
        end
      end
    end
  end
end
