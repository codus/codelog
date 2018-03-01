require 'spec_helper'

describe Codelog::Command::New do
  describe '#run' do
    let(:name) { 'change' }
    let(:options) { {} }

    subject { described_class.new name, options }
    
    before :each do
      allow(Time).to receive_message_chain(:now, :strftime) { '20180119134323984' }
      allow(subject).to receive(:puts)
      allow(subject).to receive(:system) { true }
      subject.run
    end

    it 'prints a message to notify the user about the file creation' do
      expect(subject).to have_received(:puts)
        .with('== Creating changelogs/unreleased/20180119134323984_change.yml change file based on example ==')
    end

    it 'creates a file for the unreleased partial changes' do
      expect(subject).to have_received(:system)
        .with('cp changelogs/template.yml changelogs/unreleased/20180119134323984_change.yml')
    end

    context "with 'edit' option" do
      let(:options) { { edit: true } }

      it 'opens the default text editor with the created file' do
        expect(subject).to have_received(:system)
          .with('${VISUAL:-${EDITOR:-nano}} changelogs/unreleased/20180119134323984_change.yml')
      end
    end

    context 'with a name in a non snake case format' do
      let(:name) { 'TestName' }

      it 'converts the string to snake case notation, creating the file using it' do
        expect(subject).to have_received(:system)
          .with('cp changelogs/template.yml changelogs/unreleased/20180119134323984_test_name.yml')
      end 
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run)
      described_class.run('test_name', {})
    end
  end
end
