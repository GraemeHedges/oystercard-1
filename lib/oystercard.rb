class Oystercard
  LIMIT = 90
  MINIMUM = 1
  attr_reader :balance
  def initialize(balance = 0)
    @balance = balance
    @in_use = false
  end

  def top_up(amount)
    fail "Your credit cannot go over #{LIMIT}" if amount > LIMIT - @balance
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise 'Insufficient funds for journey' if @balance < MINIMUM
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end
end
