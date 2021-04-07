require 'spec_helper'

describe Codelog::Config do
  before :each do
    stub_const('::Codelog::Config::CONFIG_FILE_PATH', '/my/path')

    allow(described_class).to receive(:settings).and_return({
      'default_changelog_filename' => 'CHANGELOGO.md',
      'header_textfile' => 'dummy_textfile.txt',
      'date_input_format' => '%Y-%m-%d',
      'date_output_format' => '%d-%m-%Y',
      'version_prefix' => '[my_version_prefix]',
      'version_suffix' => '[my_version_suffix]',
      'date_prefix' => '[my_date_prefix]',
      'show_date' => true
    })
  end

  describe '#filename' do
    it 'returns the correct filename' do
      expect(described_class.filename).to eq('CHANGELOGO.md')
    end
  end

  describe '#pending_filename' do
    it 'returns the correct pending filename' do
      expect(described_class.pending_filename).to eq('CHANGELOG_PENDING.md')
    end
  end

  describe '#pending_changelog_title' do
    it 'returns the correct pending changelog title' do
      expect(described_class.pending_changelog_title).to eq('Pending Changes')
    end
  end

  describe '#header' do
    let(:mocked_header_file) { double(File, read: 'stubbed header') }

    before :each do
      allow(File).to receive(:open).with('dummy_textfile.txt', 'r').and_return(mocked_header_file)
    end

    it 'returns the correct header from file' do
      expect(described_class.header).to eq('stubbed header')
    end
  end

  describe '#date_input_format' do
    it 'returns the correct date input format' do
      expect(described_class.date_input_format).to eq('%Y-%m-%d')
    end
  end

  describe '#version_tag' do
    it 'returns a correctly formatted version tag with date' do
      expect(described_class.version_tag('1.2.3', '2018-12-13'))
        .to eq('[my_version_prefix]1.2.3[my_version_suffix] - [my_date_prefix]13-12-2018')
    end

    it 'returns a correctly formatted version tag without date' do
      allow(described_class).to receive(:show_date?).and_return(false)

      expect(described_class.version_tag('1.2.3', '2018-12-13'))
        .to eq('[my_version_prefix]1.2.3[my_version_suffix]')
    end
  end
end
