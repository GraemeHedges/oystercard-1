class Oystercard
  LIMIT = 90
  MINIMUM = 1
  attr_reader :balance, :entry_station
  def initialize(balance = 0)
    @balance = balance
    @in_use = false
    @entry_station = nil
  end

  def top_up(amount)
    fail "Your credit cannot go over #{LIMIT}" if amount > LIMIT - @balance
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient funds for journey' if @balance < MINIMUM
    @entry_station = station
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM)
    @entry_station = nil
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end


