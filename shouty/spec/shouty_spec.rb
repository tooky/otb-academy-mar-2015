require 'shouty'

describe Person do

  describe "#within_range?" do

    it "checks that person's location is within range of another location" do
      @network = Network.new
      @chris = Person.new(@network)
      # Chris is at On the Beach
      @chris.location = [53.3934580,-2.1860490]
      # Other location is morrisons
      other_location = [53.4004700, -2.1916600]

      expect(@chris.within_range?(other_location)).to eq(true)
    end

    it "checks that person's location is not within range of another location" do
      # Chris is is at On the beach
      @network = Network.new
      @chris = Person.new(@network)
      @chris.location = [53.3934580,-2.2309100]
      # Other location is morrisons"
      other_location = [53.4773800, -2.1916600]

      expect(@chris.within_range?(other_location)).to eq(false)
    end

  end

end

