require 'spec_helper'

describe Codelog::Command::Release do
  describe '#run' do
    context 'with a valid version string' do
      context 'with the preview option' do
        let(:options) { { preview: true } }
        it 'calls only the version command, passing the options to it' do
          expect(Codelog::Command::Step::Version).to receive(:run).with '1.2.3', '12-12-2012', options
          expect(Codelog::Command::Step::Delete).to_not receive(:run)
          expect(Codelog::Command::Step::Changelog).to_not receive(:run)
          expect(subject).to_not receive(:puts).with("\n== Changelog updated to version 1.2.3 ==")
          subject.run '1.2.3', '12-12-2012', options
        end
      end

      context 'without the preview option' do
        let(:options) { { preview: false } }
        it 'calls the steps, one by one, passing the options to the version command' do
          expect(Codelog::Command::Step::Version).to receive(:run).with '1.2.3', '12-12-2012', options
          expect(Codelog::Command::Step::Delete).to receive(:run)
          expect(Codelog::Command::Step::Changelog).to receive(:run)
          expect(subject).to receive(:puts).with("\n== Changelog updated to version 1.2.3 ==")
          subject.run '1.2.3', '12-12-2012', options
        end
      end
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run).with '1.2.3', '12-12-2012', preview: false
      described_class.run '1.2.3', '12-12-2012', preview: false
    end
  end
end
