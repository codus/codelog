require 'spec_helper'

describe Codelog::Command::Step::Changelog do
  let(:mocked_changelog) { double(File) }
  let(:mocked_header_textfile) { double(File, read: 'stubbed read') }

  describe '#run' do
    before :each do
      allow(Dir).to receive(:'[]').with('changelogs/releases/*.md') { ['0.1.0.md', '0.2.0.md'] }
      allow(File).to receive(:readlines).with('0.1.0.md') { ['line_1\n'] }
      allow(File).to receive(:readlines).with('0.2.0.md') { ['line_2\n'] }
      allow(File).to receive(:open).with('textfile.txt', 'r').and_return(mocked_header_textfile)
      allow(YAML).to receive(:load_file).with('changelogs/codelog.yml') { { 'header_textfile' => 'textfile.txt' } }
    end

    it 'combines the content of the releases and put in an array' do
      expect(subject).to receive(:create_file_from)
        .with(['line_2\n', 'line_1\n'])
      subject.run
    end

    it 'creates a changelog file from the releases' do
      allow(mocked_changelog).to receive(:puts)
      expect(File).to receive(:open).with('CHANGELOG.md', 'w+').and_yield mocked_changelog
      subject.run
      expect(mocked_changelog).to have_received(:puts).with(['line_2\n', 'line_1\n'])
    end
  end

  describe '.run' do
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:run)
      described_class.run
    end
  end
end
