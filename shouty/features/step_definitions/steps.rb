class Person
  attr_writer :location
  attr_reader :heard_messages

  def initialize(network)
    @network = network
    @network.subscribe(self)
    @heard_messages = []
  end

  def shout(message)
    @network.broadcast(message)
  end

  def hear(message)
    @heard_messages << message
  end
end

class Network
  def initialize
    @people = []
  end

  def subscribe(person)
    @people << person
  end

  def broadcast(message)
    @people.each { |person| person.hear(message) }
  end
end

Given(/^James is at "(.*?)"$/) do |location|
  @network ||= Network.new
  @james = Person.new(@network)
  @james.location = location
end

Given(/^Chris is at "(.*?)"$/) do |location|
  @chris = Person.new(@network)
  @chris.location = location
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
