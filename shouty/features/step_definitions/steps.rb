module ShoutyDomain
  def the_network
    @the_network ||= Network.new
  end
end
World(ShoutyDomain)

Before do
  @locations = {}
  @people = {}
end

Given(/^the following geolocations:$/) do |location_data|
  location_data.hashes.each do |location|
    place = location["Place"]
    lat = location["Latitude"]
    long = location["Longitude"]
    @locations[place] = Location.new(Float(lat), Float(long))
  end
end

Given(/^(\w+) is at "(.*?)"$/) do |name, location|
  @people[name] = Person.new(the_network)
  @people[name].location = @locations[location]
end

When(/^(\w+) shouts "(.*?)"$/) do |name, message|
  @the_shout = message
  @people[name].shout(@the_shout)
end

When(/^(\w+) shouts:$/) do |name, message|
  @the_shout = message
  @people[name].shout(@the_shout)
end

Then(/^(\w+) doesn't hear the shout$/) do |name|
  expect(@people[name].heard_messages).not_to include(@the_shout)
end

Then(/^(\w+) hears the shout$/) do |name|
  expect(@people[name].heard_messages).to include(@the_shout)
end
