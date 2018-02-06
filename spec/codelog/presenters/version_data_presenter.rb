require 'spec_helper'

describe Codelog::Presenters::VersionDataPresenter do
  let(:stubed_date) { Date.strptime('2018-02-15') }
  let(:version_hash) { { 'Version' => '0.1.0', 'Date' => stubed_date , 'Added' => ["modifications1" , "modification2"] } }
  subject { Codelog::Presenters::VersionDataPresenter.new(version_hash) }
  it '#date' do
    expect(subject.date).to eq "2018-02-15"
  end
  it '#version' do
    expect(subject.version).to eq '0.1.0'
  end
  it '#modifications' do
    pending()
    expect(subject.modifications).to eq({ 'Added' => ["modifications1" , "modification2"] })
  end
end
