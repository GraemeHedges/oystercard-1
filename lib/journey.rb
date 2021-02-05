# require 'oystercard'
# require 'station'

class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :current_journey, :journey_history

  def initialize(entry_station = nil)
    @current_journey = {entry_station: entry_station , exit_station: nil}
    @journey_history = []
  end

  # def start(station)
  #   @current_journey[:entry_station] = station
  # end

  def finish(station)
    @current_journey[:exit_station] = station
  end

  def in_journey?
    @current_journey[:entry_station] || @current_journey[:exit_station]
  end

  def fare
    valid_journey ? MINIMUM_FARE : PENALTY_FARE
  end

  private

  def valid_journey
    current_journey[:entry_station] && current_journey[:exit_station]
  end

end

# card should
# have a balance
# top up the balance
# deduct from the balance
# touch in
# touch out