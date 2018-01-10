require 'spec_helper'

describe Codelog::CLI do
  describe '#help' do
    let(:output) { open('|ruby bin/codelog help', &:read) }
    it 'returns a list of commands to run correctly' do
      expect(output).to include 'Commands:'
    end
  end

  context 'with any valid command' do
    VALID_COMMANDS = ['setup', 'new'].freeze

    VALID_COMMANDS.each do |command|
      it "calls the #{command} command" do
        command_class = Module.const_get "Codelog::Command::#{command.capitalize}"
        allow(command_class).to receive(:run)
        subject.send(command)
        expect(command_class).to have_received(:run)
      end
    end
  end
end
