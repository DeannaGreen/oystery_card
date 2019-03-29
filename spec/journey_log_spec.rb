require 'journey_log'

describe JourneyLog do
  let(:entry_station){ {name: "Old Street", zone: 1} }
  let(:exit_station){ {name: "Old Street", zone: 1} }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  
  describe '#journeys' do
    it 'stores a journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.journeys).to include journey
    end
  end
end
