require 'station'
require 'journey'

class JourneyLog
  attr_reader :journeys, :journey, :in_journey

  def initialize(journey_class = Journey)
    @journey = journey_class.new
    @journeys = []
    @in_journey = false
  end

  def start(entry_station = Station.new)
    @journey.start(entry_station)
    @in_journey = true
  end

  def finish(exit_station = Station.new)
    @journey.finish(exit_station)
    @journeys << {entry_station: @journey.entry_station, exit_station: @journey.exit_station}
    @in_journey = false
  end

  def journeys
    @journeys
  end

  def fare
    @journey.fare
  end

  private

  def current_journey
    if @journey.exit_station == nil
      puts "Incomplete Journey"
    else
      self.start(entry_station)
    end
  end
end
