require 'spec_helper'

describe Codelog::Command::Step::Version do
  describe '#run' do
    subject { described_class.new('1.2.3', '2012-12-12') }

    let(:mocked_release_file) { double(File) }

    before :each do
      allow(Dir).to receive(:"[]").with('changelogs/unreleased/*.yml') do
        ['file_1.yml', 'file_2.yml']
      end
      allow(YAML).to receive(:load_file).with('file_1.yml') { { 'Category_1' => ['value_1'] } }
      allow(YAML).to receive(:load_file).with('file_2.yml') { { 'Category_1' => ['value_2'] } }

      allow(subject).to receive(:version_exists?).and_return(false)
      allow(subject).to receive(:has_unreleased_changes?).and_return(true)
    end

    it 'merges the content of the files with the same category' do
      expect(subject).to receive(:create_version_changelog_from)
        .with('Category_1' => ['value_1', 'value_2'])
      subject.run
    end

    it 'creates a release using the unreleased changes' do
      allow(mocked_release_file).to receive(:puts)
      allow(File).to receive(:open).with('changelogs/releases/1.2.3.md', 'a')
                                   .and_yield(mocked_release_file)
      subject.run
      expect(mocked_release_file).to have_received(:puts).with '## 1.2.3 - 2012-12-12'
      expect(mocked_release_file).to have_received(:puts).with '### Category_1'
    end

    it 'checks the existence of an already existing version of the release' do
      expect(subject).to receive(:version_exists?)
      subject.run
    end

    it 'checks the existence of change files' do
      expect(subject).to receive(:has_unreleased_changes?)
      subject.run
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run)
      described_class.run '1.2.3'
    end
  end
end
