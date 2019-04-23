require 'spec_helper'

describe Codelog::Command::Regenerate do
  describe '.run' do
    it 'calls the "Changelog" step to re-generate the CHANGELOG using existing releases' do
      allow(Codelog::Command::Step::Changelog).to receive(:run)

      described_class.run

      expect(Codelog::Command::Step::Changelog).to have_received(:run)
    end
  end
end
