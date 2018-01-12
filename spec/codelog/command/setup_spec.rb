require 'spec_helper'

describe Codelog::Command::Setup do
  describe '#run' do
    before :each do
      allow(subject).to receive(:system) { true }
      stub_const('Codelog::Command::Setup::TEMPLATE_FILE_PATH', '/my/path')
      allow(subject).to receive(:puts).with('== Creating folder structure and template ==')
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

    it 'copy the template fixture file to the changelogs folder' do
      expect(subject).to have_received(:system).with('cp /my/path changelogs/template.yml')
    end

    it 'creates a .gitkeep file on the unreleased folder' do
      expect(subject).to have_received(:system).with('touch changelogs/unreleased/.gitkeep')
    end


    it 'creates a .gitkeep file on the releases folder' do
      expect(subject).to have_received(:system).with('touch changelogs/releases/.gitkeep')
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run)
      described_class.run
    end
  end
end
