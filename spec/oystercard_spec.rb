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

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'will reduce balance by specified amount' do
      subject.top_up(10)
      expect { subject.deduct(5) }.to change {subject.balance}.by (-5) 
    end
  end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey # not_to be_in_journey gives falsy
    end
  end

  describe '#touch_in' do
    it 'can touch in' do
      subject.touch_in
      expect(subject).to be_in_journey # true, alternative: expect(subject.in_journey?).to be true 
    end
  end

  describe '#touch_out' do
    it 'in_journey be false' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey # false alternative: expect(subject.in_journey?).to be false
    end
  end
end

