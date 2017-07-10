require './lib/oystercard.rb'
oystercard = Oystercard.new
p oystercard.balance
p oystercard.top_up(20)
p oystercard.deduct(4)
