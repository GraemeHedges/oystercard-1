class Oystercard
  LIMIT = 90
  attr_reader :balance
  def initialize(balance = 0)
    @balance = balance
    @journey = false
  end

  def top_up(amount)
    fail "Your credit cannot go over #{LIMIT}" if amount > LIMIT - @balance
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end

  def in_journey?
    @journey
  end
end
