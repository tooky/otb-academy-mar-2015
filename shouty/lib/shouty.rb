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
    earths_radius = 6371
    d_lat = deg2rad(other_location[0] - @location[0])
    d_lon = deg2rad(other_location[1] - @location[1])
    a =
      Math.sin(d_lat/2) * Math.sin(d_lat/2) +
      Math.cos(deg2rad(@location[0])) * Math.cos(deg2rad(other_location[0])) *
      Math.sin(d_lon/2) * Math.sin(d_lon/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = earths_radius * c
    distance = d*1000
    puts distance
    distance < range_in_meters
  end

  def deg2rad(deg)
    deg * (Math::PI/180)
  end
end

class Network
  def initialize
    @people = []
  end

  def subscribe(person)
    @people << person
  end

  def broadcast(message, location)
    @people.each do |person|
      person.hear(message) if person.within_range?(location)
    end
  end
end

# function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
#   var R = 6371; // Radius of the earth in km
#   var dLat = deg2rad(lat2-lat1);  // deg2rad below
#   var dLon = deg2rad(lon2-lon1);
#   var a =
#     Math.sin(dLat/2) * Math.sin(dLat/2) +
#     Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
#     Math.sin(dLon/2) * Math.sin(dLon/2)
#   ;
#   var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
#   var d = R * c; // Distance in km
#   return d;
# }

# function deg2rad(deg) {
#   return deg * (Math.PI/180)
# }
