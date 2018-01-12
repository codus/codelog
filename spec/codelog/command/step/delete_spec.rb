require 'spec_helper'

describe Codelog::Command::Step::Delete do
  describe '#run' do
    before :each do
      allow(subject).to receive(:system) { true }
      subject.run
    end

    it 'removes all the files from the unreleased folder' do
      expect(subject).to have_received(:system)
        .with('rm -rv changelogs/unreleased/*.yml')
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run)
      described_class.run
    end
  end
end
