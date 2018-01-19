require 'spec_helper'

describe Codelog::Command::Release do
  describe '#run' do
    context 'with a valid version string' do
      it 'calls the steps, one by one' do
        expect(Codelog::Command::Step::Version).to receive(:run).with '1.2.3', '12-12-2012'
        expect(Codelog::Command::Step::Delete).to receive(:run)
        expect(Codelog::Command::Step::Changelog).to receive(:run)
        expect(subject).to receive(:puts).with("\n== Changelog updated to version 1.2.3 ==")
        subject.run '1.2.3', '12-12-2012'
      end
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run).with '1.2.3', '12-12-2012'
      described_class.run '1.2.3', '12-12-2012'
    end
  end
end
