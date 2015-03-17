module ShoutyDomain
  def the_network
    @the_network ||= Network.new
  end
end
World(ShoutyDomain)

Given(/^"(.*?)" is at "(.*?)"$/) do |location, lat_long|
  location_array = lat_long.split(",").map { |s| s.to_f }
  @locations ||= {}
  @locations[location] = Location.new(location_array[0],location_array[1])
end

Given(/^James is at "(.*?)"$/) do |location|
  @james = Person.new(the_network)
  @james.location = @locations[location]
end

Given(/^Chris is at "(.*?)"$/) do |location|
  @chris = Person.new(the_network)
  @chris.location = @locations[location]
end

When(/^Chris shouts "(.*?)"$/) do |message|
  @the_shout = message
  @chris.shout(@the_shout)
end

Then(/^James doesn't hear Chris' shout$/) do
  expect(@james.heard_messages).not_to include(@the_shout)
end

Then(/^James hears Chris' shout$/) do
  expect(@james.heard_messages).to include(@the_shout)
end
