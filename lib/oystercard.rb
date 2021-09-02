class Oystercard
  attr_reader :balance, :entry_station, :journey_history
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if max(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out(exit_station)
    deduct(MIN_BALANCE)
    @journey_history << {entry_station: @entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

  def max(amount)
    @balance + amount > MAX_BALANCE
  end
end