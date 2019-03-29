require 'station'
require 'journey'
require "journey_log"

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station = Station.new)
    fail "Minimum balance needs to be #{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    @journey_log.start(entry_station)
    deduct
    @entry_station = entry_station
  end

  def touch_out(exit_station = Station.new)
    @journey_log.finish(exit_station)
    deduct
    @entry_station = nil
  end

  def in_journey?
    @journey_log.in_journey
  end


  private

  def deduct
    @balance -= @journey_log.fare
  end

end
