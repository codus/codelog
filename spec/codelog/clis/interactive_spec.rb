require 'spec_helper'

describe Codelog::CLIs::Interactive do
  let(:sections_hash) { { "Added" => ["some_text"], "Removed" => ["another_text"] } }

  before :each do
    allow(YAML).to receive(:load_file).with('changelogs/template.yml').and_return sections_hash
  end

  describe '#run' do
    let(:thor_questions_responses) do
      [
        "1", "test_1:", "test_1_1", "", "test_2", "",
        "2", "test_3", "",
        "1", "test_4", ""
      ]
    end

    before :each do
      allow(subject).to receive(:say)
      allow(subject).to receive(:ask).and_return(*thor_questions_responses)
      allow(subject).to receive(:no?).with("\nWould you like to add a new log(Y|N)?")
        .and_return(false, false, true)
    end

    it 'returns a hash with the changes to be added in a new change file' do
      response = subject.run
      expect(response).to eq(
        {
          "Added" => [
            {
              "test_1" => ["test_1_1"]
            },
            "test_2",
            "test_4"
          ],
          "Removed" => ["test_3"]
        }
      )
    end
  end
end
