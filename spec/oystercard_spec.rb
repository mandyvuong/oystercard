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
  end
end

# oystercard.topup(money)
# oystercard.balance = money