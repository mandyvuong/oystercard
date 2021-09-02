require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'balance of zero' do
      expect(subject.balance).to eq (0)    
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up balance' do
      expect { subject.top_up(10) }.to change { subject.balance }.by (10)   
    end

    it 'raises an error if card beyond limit' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect {subject.top_up(1)}.to raise_error "Maximum balance of #{max_balance} exceeded"
    end
  end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey # not_to be_in_journey gives falsy
    end
  end

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  describe '#touch_in' do
    it 'can touch in' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey # true, alternative: expect(subject.in_journey?).to be true 
    end
    
    it 'raises error if below minimum balance' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient balance"
    end

    it 'records journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do
    it 'can touch out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey # false alternative: expect(subject.in_journey?).to be false
    end
    
    it 'reduce the balance by minimum fare' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change {subject.balance}.by (-Oystercard::MIN_BALANCE) 
    end

    it 'stores exit station' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end 

  it 'has an empty list of journeys by default' do
    expect(subject.journey_history).to eq []
  end

  it 'stores a journey' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journey_history).to include ( {entry_station: entry_station, exit_station: exit_station} )
  end
end

