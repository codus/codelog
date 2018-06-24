require 'spec_helper'

describe Codelog::Command::Preview do
  describe '#run' do
    subject { described_class.new.run('1.2.3', '2012-12-12') }

    let(:mock_log_outputter) { double(Codelog::Output::Log) }

    before(:each) do
      allow(Codelog::Command::Step::Version).to receive(:run)
      allow(Codelog::Output::Log).to receive(:new).and_return(mock_log_outputter)
    end

    it 'calls the log outputter to print a preview of the desired version' do
      expect(Codelog::Command::Step::Version).to receive(:run).with '1.2.3', '2012-12-12', mock_log_outputter

      subject
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run).with '1.2.3', '12-12-2012'
      described_class.run '1.2.3', '12-12-2012'
    end
  end
end
