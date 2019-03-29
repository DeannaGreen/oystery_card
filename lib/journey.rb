class Journey
  attr_reader :exit_station, :entry_station, :fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  @fare = 0

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(entry_station)
    if exit_station == nil
      @fare = PENALTY_FARE
    end
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish(exit_station)
    if entry_station == nil
      @fare = PENALTY_FARE
    else
      puts @entry_station[:zone]
      @fare = MINIMUM_FARE
    end
    @exit_station = exit_station
    self
  end

  def fare
    @fare
  end

end
