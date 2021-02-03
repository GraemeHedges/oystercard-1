require 'oystercard'

$limit = Oystercard::LIMIT
$minimum = Oystercard::MINIMUM

describe Oystercard do
  describe '@balance' do
    it 'tells the customer their balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'increases the balance of Oystercard' do
      subject.top_up($minimum)
      expect(subject.balance).to eq $minimum
    end

    it "throws an error if customer tries to increase credit above #{$limit}" do
      subject.top_up($limit)
      expect{ subject.top_up($minimum) }.to raise_error "Your credit cannot go over #{$limit}"
    end
  end

  describe '#deduct' do
    it 'deducts money from balance when customer travels' do
      subject.top_up($limit)
      subject.deduct($minimum)
      expect(subject.balance).to eq $limit - $minimum
    end
  end

  describe '#touch_in' do
    it 'allows a customer to touch in at the start of the journey when balance above minimum' do
      subject.top_up($limit)
      expect(subject.touch_in).to eq true
    end

    it 'does not allow a customer to touch in when the balance is below the minimum' do
      expect{subject.touch_in}.to raise_error 'Insufficient funds for journey'
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
      subject.top_up($minimum)      
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'still works after card #touch_in then #touch_out' do
      subject.top_up($minimum)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end