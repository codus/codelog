require 'spec_helper'
require 'date'
require 'yaml'

describe Codelog::Command::Step::Changelog do
  let!(:changelog_template) { File.read('lib/fixtures/changelog_template.md.erb') }
  let!(:codelog_file) { YAML.load_file('lib/fixtures/codelog.yml') }
  let(:mocked_changelog) { double(File) }
  let(:stubed_date) { Date.strptime('2018-02-15') }

  describe '#run' do
    before :each do
      allow(File).to receive(:read).with('changelogs/changelog_template.md.erb') { changelog_template }
      allow(Dir).to receive(:'[]').with('changelogs/releases/*.yml') { ['0.1.0.yml', '0.2.0.yml'] }
      allow(YAML).to receive(:load_file).with('changelogs/codelog.yml') { codelog_file }
      allow(YAML).to receive(:load_file).with('0.1.0.yml') { { 'Version' => '0.1.0', 'Date' => stubed_date } }
      allow(YAML).to receive(:load_file).with('0.2.0.yml') { { 'Version' => '0.2.0', 'Date' => stubed_date } }
    end

    context 'without a changelog-backup file' do
      before :each do
        allow(File).to receive(:file?).with('changelogs/releases/changelog-backup.md').and_return(false)
      end

      it 'creates CHANGELOG file' do
        expect(subject).to receive(:create_file)
        subject.run
      end

      it 'creates a changelog file from the releases' do
        allow(mocked_changelog).to receive(:puts)
        expect(File).to receive(:open).with('CHANGELOG.md', 'w+').and_yield mocked_changelog
        subject.run
      end
    end

    context 'with a changelog-backup file' do
      it 'includes changelog-backup if it exists' do
        pending('to do')
      end
    end
  end
  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run)
      described_class.run
    end
  end
end
