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

      it 'calls the release command with the preview flag' do
        allow(Codelog::Command::Preview).to receive(:run)
        subject.options = {preview: true}
        subject.release '1.2.3', '2012-12-12'
        expect(Codelog::Command::Preview).to have_received(:run).with '1.2.3', '2012-12-12'
      end
    end
  end

  describe '#regenerate' do
    it 'calls the regenerate command' do
        allow(Codelog::Command::Regenerate).to receive(:run)
        subject.regenerate
        expect(Codelog::Command::Regenerate).to have_received(:run)
    end
  end

  describe '#pending' do
    context 'passing the title as an argument' do
      it 'calls the pending command' do
        allow(Codelog::Command::Pending).to receive(:run)
        subject.pending 'Pending Changes'
        expect(Codelog::Command::Pending).to have_received(:run).with 'Pending Changes'
      end
    end
  end

  describe '#bump' do
    it 'calls the bump command' do
      default_options = {}
      allow(Codelog::Command::Bump).to receive(:run)
      subject.bump 'major', '2012-12-12'
      expect(Codelog::Command::Bump).to have_received(:run).with 'major', '2012-12-12', default_options
    end
  end
end
