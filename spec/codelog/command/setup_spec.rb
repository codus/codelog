require 'spec_helper'

describe Codelog::Command::Setup do
  describe '#run' do
    before :each do
      allow(subject).to receive(:system) { true }
      stub_const('Codelog::Command::Setup::TEMPLATE_FILE_PATH', '/my/path')
      stub_const('Codelog::Command::Setup::CONFIG_FILE_PATH', '/my/config_path')
      allow(subject).to receive(:puts).with('== Creating folder structure and template ==')
      allow(File).to receive(:file?).and_return(false)
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

  describe '#handle_existing_changelog' do
    before :each do
      allow(subject).to receive(:system) { true }
      stub_const('Codelog::Command::Setup::TEMPLATE_FILE_PATH', '/my/path')
      stub_const('Codelog::Command::Setup::CONFIG_FILE_PATH', '/my/config_path')

      allow(subject).to receive(:puts).with('== Creating folder structure and template ==')
      allow(File).to receive(:file?).and_return(true)
    end


    it 'prompts a message asking if the old file should be versioned' do
      allow(subject).to receive(:receive).and_return true
      allow(subject).to receive(:puts).with('== Copying existing changelog to releases folder ==')

      expect(subject).to receive(:puts).with(Codelog::Message::Warning.mantain_versioning_of_existing_changelog?)

      subject.run
    end

    it 'calls the copy changelog method' do
      allow(subject).to receive(:yes?).with(Codelog::Message::Warning.mantain_versioning_of_existing_changelog?).and_return(true)

      expect(subject).to receive(:puts).with('== Copying existing changelog to releases folder ==')
      expect(subject).to receive(:copy_and_mark_changelog)

      subject.run
    end

    it 'prompts a message asking if the old file should be deleted' do
      allow(subject).to receive(:receive).and_return false
      allow(subject).to receive(:puts).with(Codelog::Message::Warning.mantain_versioning_of_existing_changelog?)

      expect(subject).to receive(:puts).with(Codelog::Message::Warning.delete_existing_changelog?)

      subject.run
    end

    it 'deletes the existing changelog if prompted' do
      allow(subject).to receive(:yes?).with(Codelog::Message::Warning.mantain_versioning_of_existing_changelog?).and_return(false)
      allow(subject).to receive(:yes?).with(Codelog::Message::Warning.delete_existing_changelog?).and_return(true)

      expect(subject).to receive(:puts).with('== Deleting existing changelog ==')
      expect(subject).to receive(:system).with('rm CHANGELOG.md')

      subject.run
    end
  end

  describe '#receive' do
    it 'returns true when prompted y or Y' do
      allow($stdin).to receive(:gets).and_return('y', 'Y')

      expect(subject.send(:receive)).to eq true
      expect(subject.send(:receive)).to eq true
    end

    it 'returns false when prompted n' do
      allow($stdin).to receive(:gets).and_return('n')
      expect(subject.send(:receive)).to eq false
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run)
      described_class.run
    end
  end
end
