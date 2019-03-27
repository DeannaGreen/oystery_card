require 'station'
require 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
    @journey = Journey.new
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Minimum balance needs to be #{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(@journey.finish(exit_station).fare)
    @exit_station = exit_station
    @journeys << {entry_station: entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end


  private

  def deduct(amount)
    @balance -= amount
  end

end
