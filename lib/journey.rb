class Journey
  attr_reader :complete

  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  def initialize
    @complete = false
  end

  def finish(station)
    @complete = true
    self
  end

  def fare
    if complete?
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end

  def complete?
    @complete
  end

end
