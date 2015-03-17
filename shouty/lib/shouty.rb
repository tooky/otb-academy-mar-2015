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
