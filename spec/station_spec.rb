require 'station'

describe Station do

  let(:station) { Station.new('Stratford', 2) }

  it 'knows its own name' do
    expect(station.name).to eq('Stratford')
  end

  it 'knows its own zone' do
    expect(station.zone).to eq 2
  end
end