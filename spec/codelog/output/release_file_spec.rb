require 'spec_helper'

describe Codelog::Output::ReleaseFile do
  let(:file_content) { 'test' }
  let(:file_path) { 'codus/codelog'}
  let(:mocked_file) { double }

  describe '#print' do
    subject { described_class.new(file_path).print(file_content) }
    before(:each) do
      allow(File).to receive(:open).and_yield(mocked_file)
      allow(mocked_file).to receive(:puts)
    end

    it 'prints the passed content in a file on the passed path' do
      subject

      expect(File).to have_received(:open).with(file_path, 'a')
      expect(mocked_file).to have_received(:puts).with(file_content)
    end
  end

  describe '.print' do
    subject { described_class.print(content, file_path) }
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:print).with 'test'
      described_class.print 'test', 'codus/codelog'
    end
  end
end
