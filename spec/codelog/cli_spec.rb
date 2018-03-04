require 'spec_helper'

describe Codelog::CLI do
  describe 'with the help command' do
    let(:output) { open('|ruby bin/codelog help', &:read) }
    it 'returns a list of commands to run correctly' do
      expect(output).to include 'Commands:'
    end
  end

  describe '#new' do
    before :each do
      allow(Codelog::Command::New).to receive(:run)
    end

    it 'calls the new command' do
      subject.new
      expect(Codelog::Command::New).to have_received(:run)
    end

    it 'pass the change name to the command' do
      default_options = {}
      subject.new('test_name')
      expect(Codelog::Command::New).to have_received(:run).with('test_name', default_options)
    end
  end

  describe '#setup' do
    before :each do
      allow(Codelog::Command::Setup).to receive(:run)
    end

    it 'calls the setup command' do
      subject.setup
      expect(Codelog::Command::Setup).to have_received(:run)
    end
  end

  describe '#release' do
    context 'passing the version as an argument' do
      it 'calls the release command' do
        allow(Codelog::Command::Release).to receive(:run)
        subject.release '1.2.3', '2012-12-12'
        expect(Codelog::Command::Release).to have_received(:run).with '1.2.3', '2012-12-12'
      end
    end
  end
end
