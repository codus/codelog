require 'spec_helper'

describe Codelog::Command::Pending do
  describe '#run' do
    let(:mock_file_outputter) { double(Codelog::Output::ReleaseFile) }

    it 'calls' do
      allow(Codelog::Command::Step::Version).to receive(:new)
      allow(Codelog::Output::ReleaseFile).to receive(:new).and_return(mock_file_outputter)

      expect(Codelog::Command::Step::Version).to receive(:run).with('Pending Changes', Date.today.strftime(Codelog::Config.date_input_format), mock_file_outputter)
      expect(Codelog::Command::Step::Changelog).to receive(:run)
      expect(subject).to receive(:puts).with("\n== Pending changes added to changelog ==")
      subject.run 'Pending Changes'
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run).with 'Pending Changes'
      described_class.run 'Pending Changes'
    end
  end
end
