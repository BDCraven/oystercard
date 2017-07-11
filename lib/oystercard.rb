class Oystercard

  MAXIMUM_BALANCE = 20
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    entry_station.nil? ? false : true
  end

  def touch_in(station)
    raise "Cannot touch in, balance less than #{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE) #Why aren't we checking for balance going below MINIMUM_BALANCE
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
