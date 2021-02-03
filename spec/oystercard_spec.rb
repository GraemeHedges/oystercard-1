require 'oystercard'

describe Oystercard do
  describe '@balance' do
    it 'tells the customer their balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'increases the balance of Oystercard' do
      subject.top_up(20)
      expect(subject.balance).to eq 20
    end

    it 'throws an error if customer tries to increase credit above 90' do
      card = Oystercard.new
      card.top_up(80)
      expect{ card.top_up(20) }.to raise_error 'Your credit cannot go over 90'
    end
  end

  describe '#deduct' do
    it 'deducts money from balance when customer travels' do
      subject.top_up(90)
      subject.deduct(5)
      expect(subject.balance).to eq 85
    end
  end

  describe '#touch_in' do
    it 'allows a customer to touch in at the start of the journey' do
      expect(subject.touch_in).to eq true
    end
  end

  describe '#touch_out' do
    it 'allows a customer to touch out after a journey has ended' do
      expect(subject.touch_out).to eq false
    end
  end

  describe '#in_journey?' do
    it 'returns whether card is in use' do
      expect(subject).not_to be_in_journey
    end

    it 'returns whether a card is in use after #touch_in' do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'still works after card #touch_in then #touch_out' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end