require 'oystercard'

describe Oystercard do
  let(:entry_station){ {name: "Old Street", zone: 1} }
  let(:exit_station){ {name: "Old Street", zone: 1} }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do

    it 'balance can be topped up' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it 'raises an error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up (max_balance)
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{max_balance} exceeded"
    end
  end

  describe '#touch_in' do
    before(:each) do
      subject.top_up(10)
      subject.touch_in(entry_station)
    end

    it 'card is in use if #touch_in is called' do
      expect(subject.in_journey?).to be_truthy
    end

    it 'remembers the entry station' do
      expect(subject.entry_station).to eq entry_station
    end

    it 'charges penalty fare if not touched_out' do
      expect(subject.balance).to eq 4
    end
  end

  describe '#touch_out' do
    before(:each) do
      subject.top_up(8)
      subject.touch_in(entry_station)
    end

    it 'charges minimum fare' do
      subject.touch_out(exit_station)
      expect(subject.balance).to eq 1
    end

    it 'card is not in use if #touch_in is called' do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to be_falsey
    end

    it 'reduces balance by fare price when touch_out' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -1
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
  end

  describe 'minimum balence' do
    it 'card has to have minimum value of £1' do
      min_balance = Oystercard::MINIMUM_BALANCE
      expect{ subject.touch_in(entry_station) }.to raise_error "Minimum balance needs to be #{min_balance}"
    end
  end

end
