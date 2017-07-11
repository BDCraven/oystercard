require_relative '../lib/oystercard.rb'
require_relative '../lib/station.rb'

oystercard = Oystercard.new
station = Station.new

p oystercard.balance
p oystercard.top_up(20)
# p oystercard.deduct(4)
# p oystercard.deduct(16)

begin
  p oystercard.touch_in(station)
rescue => exception
  puts exception.inspect
end

p oystercard.in_journey?
oystercard.touch_out
p oystercard.balance
# => 19
p oystercard.in_journey?

oystercard.touch_in(station)
puts "Touched in at #{oystercard.entry_station}"
oystercard.touch_out
puts "Touched out " if oystercard.entry_station == nil
