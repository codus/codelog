require 'spec_helper'

describe Codelog::Command::New do
  describe '#run' do
    before :each do
      allow(Time).to receive_message_chain(:now, :strftime) { '20180119134323984' }
      allow(subject).to receive(:puts)
      allow(subject).to receive(:system) { true }
    end

    context 'with no additional options' do
      let(:options) { Hash.new }

      before :each do
        subject.run(options)
      end

      it 'prints a message to notify the user about the file creation' do
        expect(subject).to have_received(:puts)
        .with('== Creating changelogs/unreleased/20180119134323984_change.yml change file based on example ==')
      end

      it 'creates a file for the unreleased partial changes' do
        expect(subject).to have_received(:system)
        .with('cp changelogs/template.yml changelogs/unreleased/20180119134323984_change.yml')
      end
    end

    context "with \e[34medit\e[0m option" do
      let(:options) {{ edit: true }}

      before :each do
        subject.run(options)
      end

      it 'prints a message to notify the user about the file creation' do
        expect(subject).to have_received(:puts)
        .with('== Creating changelogs/unreleased/20180119134323984_change.yml change file based on example ==')
      end

      it 'creates a file for the unreleased partial changes' do
        expect(subject).to have_received(:system)
        .with('cp changelogs/template.yml changelogs/unreleased/20180119134323984_change.yml')
      end

      it 'opens the default text editor with the created file' do
        expect(subject).to have_received(:system)
        .with('${VISUAL:-${EDITOR:-nano}} changelogs/unreleased/20180119134323984_change.yml')
      end
    end

    context "with \e[35minteractive\e[0m option" do
      let(:options) { { interactive: true } }
      let(:mocked_interactive_object) { double(Codelog::CLIs::Interactive) }
      let(:mocked_hash) do
        {
          "Added" => [
            {
              "test_1" => ["test_1_1"]
            },
            "test_2"
          ],
          "Removed"=>["test_3"]
        }
      end
      let(:mocked_file) { double(File) }

      before :each do
        allow(File).to receive(:open).with('changelogs/unreleased/20180119134323984_change.yml', 'a')
          .and_yield(mocked_file)
        allow(mocked_file).to receive(:puts)
        allow(Codelog::CLIs::Interactive).to receive(:new).and_return(mocked_interactive_object)
        allow(mocked_interactive_object).to receive(:run).and_return(mocked_hash)
        subject.run(options)
      end

      it 'calls the interactive hash creation method' do
        expect(Codelog::CLIs::Interactive).to have_received(:new)
        expect(mocked_interactive_object).to have_received(:run)
      end

      it 'builds the change file from a hash' do
        expect(mocked_file).to have_received(:puts)
          .with("---\nAdded:\n- test_1:\n  - test_1_1\n- test_2\nRemoved:\n- test_3\n")
        subject.run(options)
      end

      it 'prints a message to notify the user about the file creation' do
        expect(subject).to have_received(:puts)
          .with('== Creating changelogs/unreleased/20180119134323984_change.yml change file from the provided changes ==')
      end
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      options = {}

      expect_any_instance_of(described_class).to receive(:run).with(options)
      described_class.run(options)
    end
  end
end
