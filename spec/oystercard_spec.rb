require 'oystercard'

describe Oystercard do

  subject(:card)  { described_class.new }
  let(:station)   {double(:station)}

  it {is_expected.to respond_to(:entry_station)}

  describe '#new' do

    it 'has a balance of zero' do
      expect(card.balance).to eq(0)
    end

  end

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

  describe '#in_journey?' do

    it 'determines if the user is in journey' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do

    it 'knows it is in journey when touched in' do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    it 'remembers the entry station when touched in' do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(station)
      expect(card.entry_station).to eq station
    end

    it 'does not allow touch in below a minimum balance' do
      expect { card.touch_in(station) }.to raise_error "Cannot touch in, balance less than #{Oystercard::MINIMUM_BALANCE}"
    end

  end

  describe '#touch_out' do

    before do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(station)
    end

    it 'knows journey has ended' do
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'forgets the entry station when touched out' do
      expect { card.touch_out }.to change {card.entry_station}.to nil
    end

    it 'reduces balance by minimum balance' do
      expect { card.touch_out }.to change { card.balance }.by(-Oystercard::MINIMUM_FARE)
    end

  end

end
