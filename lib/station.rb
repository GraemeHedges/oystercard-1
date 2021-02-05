require 'oystercard'
require 'journey'

class Station

  attr_reader :name, :zone

  def initialize(name = "Station", zone = 0)
    @name = name
    @zone = zone
  end

end
