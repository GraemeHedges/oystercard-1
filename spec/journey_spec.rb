require 'journey'

describe Journey do
  let(:station) {double :station}
  let(:other_station) {double :other_station}

  # all of these are basic functionality tests

  describe 'initial state of the journey class' do
    it 'has an empty current journey' do
      expect(subject.current_journey).to eq({entry_station:nil, exit_station: nil})
    end

    it 'has an empty journey history' do
      expect(subject.journey_history).to be_empty
    end
  end

  # describe 'start a journey' do 
  #   it 'can take a start station and add that to the current journey' do
  #     expect(subject.start(station)).to eq subject.current_journey[:entry_station]
  #   end
  # end

  describe '#finish' do
    it 'can take an exit station and add that to the current journey' do
      expect(subject.finish(station)).to eq subject.current_journey[:exit_station]
    end
  end

  describe '#in_journey?' do
    it 'expects to be false if not currently in a journey' do
      expect(subject).not_to be_in_journey
    end

    # it 'expects to be true if a start station has been recorded' do
    #   subject.start(station)
    #   expect(subject).to be_in_journey
    # end

    it 'expects to be true if an exit station has been recorded' do
      subject.finish(other_station)
      expect(subject).to be_in_journey
    end
  end

  describe '#fare' do
    it 'returns the minimum fare with a valid entry and exit station' do
      journey = Journey.new(station)
      journey.finish(other_station)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it 'returns the penalty fair if either station is not valid' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end
    
end