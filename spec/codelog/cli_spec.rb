require 'spec_helper'

describe Codelog::CLI do
  describe 'with the help command' do
    let(:output) { open('|ruby bin/codelog help', &:read) }
    it 'returns a list of commands to run correctly' do
      expect(output).to include 'Commands:'
    end
  end

  context 'with generic commands' do
    GENERIC_COMMANDS = ['setup', 'new'].freeze

    GENERIC_COMMANDS.each do |command|
      it "calls the #{command} command" do
        command_class = Module.const_get "Codelog::Command::#{command.capitalize}"
        allow(command_class).to receive(:run)
        subject.send(command)
        expect(command_class).to have_received(:run)
      end
    end
  end

  describe '#release' do
    context 'passing the version as an argument' do
      it 'calls the release command' do
        allow(Codelog::Command::Release).to receive(:run)
        subject.release '1.2.3'
        expect(Codelog::Command::Release).to have_received(:run).with '1.2.3', nil
      end
    end
  end
end
