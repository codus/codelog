require 'spec_helper'

describe Codelog::Command::Bump do
  describe '#run' do
    let(:files) do
       [
         'changelogs/releases/0.0.0.md',
         'changelogs/releases/1.2.3.md',
         'changelogs/releases/bla.txt',
         'changelogs/releases/.gitignore',
         'changelogs/releases/md1.2.4.md'
       ]
    end

    before do
      allow(Dir).to receive(:glob).and_return(files)
      allow(Codelog::Command::Release).to receive(:run)
    end

    context 'with valid parameters' do

      context 'when it receives the \'major\' argument' do
        it 'calls the release command with the version\'s major' do
          subject.run 'major', '12-12-2012', preview: false
          expect(Codelog::Command::Release).to have_received(:run).with('2.0.0', '12-12-2012', preview: false)
        end
      end

      context 'when it receives the \'minor\' argument' do
        it 'increments the version\'s minor' do
          subject.run 'minor', '12-12-2012', preview: false

          expect(Codelog::Command::Release).to have_received(:run).with('1.3.0', '12-12-2012', preview: false)
        end
      end

      context 'when it receives the \'patch\' argument' do
        it 'increments the version\'s patch' do
          subject.run 'patch', '12-12-2012', preview: false

          expect(Codelog::Command::Release).to have_received(:run).with('1.2.4', '12-12-2012', preview: false)
        end
      end

      context 'when there is no previous release' do
        before do
          allow(Dir).to receive(:glob).and_return([])
        end

        it 'calls the release command bumping from the 0.0.0 version' do
          subject.run 'minor', '12-12-2012', preview: false

          expect(Codelog::Command::Release).to have_received(:run).with('0.1.0', '12-12-2012', preview: false)
        end
      end
    end

    context 'with a invalid parameter' do
      before do
        allow_any_instance_of(described_class).to receive(:abort)
      end

      it 'prints an error message' do
        expect_any_instance_of(described_class).to receive(:abort).with Codelog::Message::Error.invalid_version_type('bla')
        subject.run 'bla', '12-12-2012', preview: false
      end
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run).with 'major', '12-12-2012', preview: false
      described_class.run 'major', '12-12-2012', preview: false
    end
  end
end
