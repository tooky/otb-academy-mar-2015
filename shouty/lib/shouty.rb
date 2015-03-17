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
