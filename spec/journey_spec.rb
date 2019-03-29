require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1}
  let(:entry_station){ {name: "Old Street", zone: 1} }
  let(:exit_station){ {name: "Old Street", zone: 3} }

  it 'has a penalty fare' do
    expect(Journey::PENALTY_FARE).to eq 6
  end

  it 'returns the journey when finishing a journey' do
    expect(subject.finish(station)).to eq (subject)
  end

  context 'given an exit station' do
    let(:other_station) {double :other_station }

    before do
      subject.finish(other_station)
    end

    it 'calculates a fare' do
      expect(subject.fare).to eq 6
    end
  end

  it 'remembers the exit station' do
    subject.finish(exit_station)
    expect(subject.exit_station).to eq exit_station
  end
end
