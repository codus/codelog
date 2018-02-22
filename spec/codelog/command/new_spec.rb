require 'spec_helper'

describe Codelog::Command::New do
  describe '#run' do
    before :each do
      allow(Time).to receive_message_chain(:now, :strftime) { '20180119134323984' }
      allow(subject).to receive(:puts)
      allow(subject).to receive(:system) { true }
      subject.run(options)
    end

    context 'with no additional options' do
      let(:options) { Hash.new }

      it 'prints a message to notify the user about the file creation' do
        expect(subject).to have_received(:puts)
        .with('== Creating changelogs/unreleased/20180119134323984_change.yml change file based on example ==')
      end

      it 'creates a file for the unreleased partial changes' do
        expect(subject).to have_received(:system)
        .with('cp changelogs/template.yml changelogs/unreleased/20180119134323984_change.yml')
      end
    end

    context "with 'edit' option" do
      let(:options) {{ edit: true }}

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
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      options = {}

      expect_any_instance_of(described_class).to receive(:run).with(options)
      described_class.run(options)
    end
  end
end
