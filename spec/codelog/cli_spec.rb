require 'spec_helper'

describe Codelog::CLI do
  describe '#help' do
    let(:output) { open('|ruby bin/codelog help', &:read) }
    it 'returns a list of commands to run correctly' do
      expect(output).to include 'Commands:'
    end
  end

  describe '#setup' do
    it 'calls the setup method' do
      allow(Codelog::Command::Setup).to receive(:run)
      subject.setup
      expect(Codelog::Command::Setup).to have_received(:run)
    end
  end
end
