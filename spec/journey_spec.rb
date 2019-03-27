require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1}

  it 'knows if a journey is not complete' do
    expect(subject).not_to be_complete
  end

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
      expect(subject.fare).to eq 2
    end

    it 'knows if a journey is complete' do
      expect(subject).to be_complete
    end
  end
end
