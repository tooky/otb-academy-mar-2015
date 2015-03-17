class Person
  attr_writer :location
  attr_reader :heard_messages

  def initialize(network)
    @network = network
    @network.subscribe(self)
    @heard_messages = []
  end

  def shout(message)
    @network.broadcast(message, @location)
  end

  def hear(message)
    @heard_messages << message
  end

  def within_range?(other_location)
    range_in_meters = 1000
    distance = @location.distance_from(other_location)
    distance < range_in_meters
  end

end

class Location

  attr_reader :latitude, :longitude

  def initialize(latitude,longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def distance_from(other_location)
    earths_radius = 6371
    d_lat = deg2rad(other_location.latitude - latitude)
    d_lon = deg2rad(other_location.longitude - longitude)
    a =
      Math.sin(d_lat/2) * Math.sin(d_lat/2) +
      Math.cos(deg2rad(latitude)) * Math.cos(deg2rad(other_location.latitude)) *
      Math.sin(d_lon/2) * Math.sin(d_lon/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = earths_radius * c
    d*1000
  end

  def deg2rad(deg)
    deg * (Math::PI/180)
  end

end

class Network
  def initialize(max_length: 140)
    @people = []
    @max_length = max_length
  end

  def subscribe(person)
    @people << person
  end

  def broadcast(message, location)
    return if message_too_long?(message)
    @people.each do |person|
      person.hear(message) if person.within_range?(location)
    end
  end

  def message_too_long?(message)
    message.length > @max_length
  end
end
