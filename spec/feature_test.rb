require_relative '../lib/oystercard.rb'
oystercard = Oystercard.new
p oystercard.balance
p oystercard.top_up(20)
p oystercard.deduct(4)
p oystercard.deduct(16)

begin
  p oystercard.touch_in
rescue => exception
  puts exception.inspect
end

p oystercard.top_up(20)
oystercard.touch_in
p oystercard.in_journey?
oystercard.touch_out
p oystercard.balance
# => 19
p oystercard.in_journey?
