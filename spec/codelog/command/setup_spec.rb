require 'spec_helper'

describe Codelog::Command::Setup do
  describe '#run' do
    before :each do
      allow(subject).to receive(:system) { true }
      allow($stdout).to receive(:puts)
      subject.run
    end

    it 'creates a folder for the changelogs' do
      expect(subject).to have_received(:system).with('mkdir changelogs/')
    end

    it 'creates a subfolder for the unreleased changes' do
      expect(subject).to have_received(:system).with('mkdir changelogs/unreleased')
    end

    it 'creates a subfolder for the released changes' do
      expect(subject).to have_received(:system).with('mkdir changelogs/releases')
    end

    it 'creates a template file' do
      expect(subject).to have_received(:system).with('touch changelogs/template.yml')
    end
  end
end
