class Person
  attr_writer :location

  def shout(message)
  end

  def heard_messages
    []
  end
end

Given(/^James is at "(.*?)"$/) do |location|
  @james = Person.new
  @james.location = location
end

Given(/^Chris is at "(.*?)"$/) do |location|
  @chris = Person.new
  @chris.location = location
end

When(/^Chris shouts "(.*?)"$/) do |message|
  @chris.shout(message)
end

Then(/^James doesn't hear Chris' shout$/) do
  unless @james.heard_messages.empty?
    fail "James heard the message"
  end
end
