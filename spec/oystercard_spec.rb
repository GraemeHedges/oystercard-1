require 'oystercard'

$limit = Oystercard::LIMIT
$minimum = Oystercard::MINIMUM

describe Oystercard do
  
  before (:each) do
    subject.top_up($limit)
  end

  describe '@balance' do
    it 'tells the customer their balance' do
      expect(subject.balance).to eq $limit
    end
  end

  describe '#top_up' do
    it 'increases the balance of Oystercard' do
      expect(subject.balance).to eq $limit
    end

    it "throws an error if customer tries to increase credit above #{$limit}" do
      expect{ subject.top_up($minimum) }.to raise_error "Your credit cannot go over #{$limit}"
    end
  end

  describe '#deduct' do
    it 'deducts money from balance when customer travels' do
      subject.touch_out("Waterloo")
      expect(subject.balance).to eq $limit - $minimum
    end
  end

  describe '#touch_in' do
    it 'does not allow a customer to touch in when the balance is below the minimum' do
      subject = Oystercard.new
      expect{subject.touch_in("Victoria")}.to raise_error 'Insufficient funds for journey'
    end

    it 'remembers the entry station at the start of a journey' do
      station = double
      allow(station).to receive(:name) { "Victoria" }
      subject.touch_in(station.name)
      expect(subject.entry_station).to eq station.name
    end
  end

  describe '#touch_out' do
    it 'deducts the minimum amount from the balance when touched out' do
      expect{subject.touch_out("Waterloo")}.to change{subject.balance}.by -$minimum
    end

    it 'forgets entry_station when journey ends' do
      subject.touch_in("Victoria")
      expect{ subject.touch_out("Waterloo") }.to change{subject.entry_station}.to nil
    end

    it 'takes an exit station as an argument' do
      station = double
      allow(station).to receive(:name) { "Waterloo"}
      subject.touch_out(station.name)
      expect(subject.journey_history[0][:exit_station]).to eq station.name
    end
  end

  describe '#in_journey?' do
    it 'expect a new cards initial state not to be in a journey' do
      expect(subject).not_to be_in_journey
    end

    describe '#in_journey after a card is touched in' do      
      before(:each) do
        subject.touch_in("Victoria")
      end
          
      it 'returns whether a card is in use after #touch_in' do
        expect(subject).to be_in_journey
      end
  
     it 'still works after card #touch_in then #touch_out' do
        subject.touch_out("Waterloo")
        expect(subject).not_to be_in_journey
      end      
    end
  end

  describe 'journey_history' do
    it 'expects a card to have no journy history when it is new' do
      expect(subject.journey_history).to be_empty
    end

    it 'expects touching in and out to add an entry and exit station to journey history' do
      subject.touch_in("Victoria")
      subject.touch_out("Waterloo")
      expect(subject.journey_history).to eq [{entry_station: "Victoria", exit_station: "Waterloo"}]
    end
  end
end


# context blocks

# new card
# has no balance
# has no journey history
# can be topped up
# can be touched in
# can be touched out

# card in a journey
# set up - has a a balance, has an entry station
# 
# can be touched out

# it tests:
# 'expects touching in and out to add an entry and exit station to journey history'
# 'expects a card to have no journy history when it is new'
# 'still works after card #touch_in then #touch_out'
# 'returns whether a card is in use after #touch_in'