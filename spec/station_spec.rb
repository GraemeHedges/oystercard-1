require 'station'

describe Station do
  
  describe '#name' do
    it 'has a default name on creation' do
      expect(subject.name).to eq "Station"
    end

    it 'can specify a name on creation' do
      waterloo = Station.new("Waterloo")
      expect(waterloo.name).to eq "Waterloo"
    end
  end

  describe '#zone' do
    it 'has a default zone on creation' do
      expect(subject.zone).to eq 0
    end

    it 'can specify a zone on creation' do
      waterloo = Station.new("Waterloo", 1)
      expect(waterloo.zone).to eq 1
    end
  end
end