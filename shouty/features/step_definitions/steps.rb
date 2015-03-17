module ShoutyDomain
  def the_network
    @the_network ||= Network.new
  end
end
World(ShoutyDomain)

Given(/^the following geolocations:$/) do |locations|
  @locations ||= {}
  locations.hashes.each do |location|
    place = location["Place"]
    lat = location["Latitude"]
    long = location["Longitude"]
    @locations[place] = Location.new(Float(lat), Float(long))
  end
end

Given(/^(\w+) is at "(.*?)"$/) do |name, location|
  @people ||= {}
  @people[name] = Person.new(the_network)
  @people[name].location = @locations[location]
end

When(/^Chris shouts "(.*?)"$/) do |message|
  @the_shout = message
  @people["Chris"].shout(@the_shout)
end

When(/^Chris shouts:$/) do |message|
  @the_shout = message
  @people["Chris"].shout(@the_shout)
end

Then(/^James doesn't hear Chris' shout$/) do
  expect(@people["James"].heard_messages).not_to include(@the_shout)
end

Then(/^James hears Chris' shout$/) do
  expect(@people["James"].heard_messages).to include(@the_shout)
end
