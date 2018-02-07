require 'spec_helper'

describe Codelog::Config do
  before :each do
    stub_const('::Codelog::Config::CONFIG_FILE_PATH', '/my/path')

    allow(described_class).to receive(:settings).and_return({
      'default_changelog_filename' => 'CHANGELOGO.md',
      'date_input_format' => '%Y-%m-%d',
      'version_prefix' => '[my_version_prefix]',
      'version_suffix' => '[my_version_suffix]',
    })
  end

  describe '#filename' do
    it 'returns the correct filename' do
      expect(described_class.filename).to eq('CHANGELOGO.md')
    end
  end

  describe '#date_input_format' do
    it 'returns the correct date input format' do
      expect(described_class.date_input_format).to eq('%Y-%m-%d')
    end
  end

  describe '#version_tag' do
    it 'returns a correctly formatted version tag' do
      expect(described_class.version_tag('1.2.3'))
        .to eq('[my_version_prefix]1.2.3[my_version_suffix]')
    end
  end
end
