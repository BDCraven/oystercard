require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new }

  describe '#new' do

    it 'has a balance of zero' do
      expect(card.balance).to eq(0)
    end

  end

  # before do
  #  card.top_up(Oystercard::MAXIMUM_BALANCE)
  # end

  describe "#top_up" do

    it "can top up the balance" do
      expect{ card.top_up 1}.to change{ subject.balance }.by 1
    end

    it "raises an error if the maximum balance is exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      card.top_up(maximum_balance)
      expect{ card.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#deduct' do

    it 'deducts an amount from the balance' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      card.top_up(maximum_balance)
      expect { card.deduct(3) }.to change { subject.balance }.by -3
    end

  end

  describe '#in_journey?' do

    it 'determines if the user is in journey' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do

    it 'knows it is in journey when touched in' do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'does not allow touch in below a minimum balance' do
      expect { card.touch_in }.to raise_error "Cannot touch in, balance less than #{Oystercard::MINIMUM_BALANCE}"
    end

  end

  describe '#touch_out' do

    it 'knows journey has ended' do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'reduces balance by minimum balance' do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in
      expect { card.touch_out }.to change { card.balance }.by(-Oystercard::MINIMUM_FARE)
    end


  end

end
