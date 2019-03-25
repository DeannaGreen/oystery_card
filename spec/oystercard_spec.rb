require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument}

    it 'balance can be topped up' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it 'raises an error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up (max_balance)
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{max_balance} exceeded"
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it 'card is in use if #touch_in is called' do
      subject.top_up(5)
      subject.touch_in
      expect(subject.in_journey?).to be_truthy
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it 'card is not in use if #touch_in is called' do
      subject.top_up(5)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to be_falsey
    end

    it 'reduces balance by fare price when touch_out' do
      min_fare = Oystercard::MINIMUM_FARE
      subject.top_up(5)
      subject.touch_in
      expect{ subject.touch_out }.to change{ subject.balance }.by -(min_fare)
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
  end

  describe 'minimum balence' do
    it 'card has to have minimum value of £1' do
      min_balance = Oystercard::MINIMUM_BALANCE
      expect{ subject.touch_in }.to raise_error "Minimum balance needs to be #{min_balance}"
    end
  end

end
