require 'spec_helper'

describe Codelog::Command::Bump do
  describe '#run' do
    before do
      allow(Dir).to receive_message_chain(:glob, :map).and_return(['0.0.0','1.2.3'])
      allow(Codelog::Command::Release).to receive(:run)
    end

    context 'with valid parameters' do

      context 'when it receives the \'major\' argument' do
        it 'calls the release command with the version\'s major' do
          subject.run 'major', '12-12-2012'
          expect(Codelog::Command::Release).to have_received(:run).with('2.0.0', '12-12-2012')
        end
      end

      context 'when it receives the \'minor\' argument' do
        it 'increments the version\'s minor' do
          subject.run 'minor', '12-12-2012'

          expect(Codelog::Command::Release).to have_received(:run).with('1.3.0', '12-12-2012')
        end
      end

      context 'when it receives the \'patch\' argument' do
        it 'increments the version\'s patch' do
          subject.run 'patch', '12-12-2012'

          expect(Codelog::Command::Release).to have_received(:run).with('1.2.4', '12-12-2012')
        end
      end
    end

    context 'with a invalid parameter' do
      before do
        allow_any_instance_of(described_class).to receive(:abort)
      end

      it 'prints an error message' do
        expect_any_instance_of(described_class).to receive(:abort).with Codelog::Message::Error.invalid_version_type('bla')
        subject.run 'bla', '12-12-2012'
      end
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run).with 'major', '12-12-2012'
      described_class.run 'major', '12-12-2012'
    end
  end
end
