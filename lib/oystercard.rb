class Oystercard

  MAXIMUM_BALANCE = 20
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    in_journey
  end

  def touch_in
    raise "Cannot touch in, balance less than #{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  private
  attr_reader :in_journey

end
