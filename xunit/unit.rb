class FailedAssertion < StandardError; end

def assert(condition)
  raise FailedAssertion unless condition
end

begin
  assert 1 == 2
rescue FailedAssertion
end

begin
  assert 1 == 1
rescue FailedAssertion
  raise 'assertion failed that should not have'
end

class WasRun
  attr_reader :was_run, :was_setup
  def initialize(name)
    @name = name
  end

  def setup
    @was_setup = true
  end

  def run
    setup
    public_send(@name)
  end

  def test_method
    @was_run = true
  end
end

# a test method is invoked
test = WasRun.new("test_method")
test.run
assert test.was_run

# the setup method is invoked
test = WasRun.new("test_method")
test.run
assert test.was_setup


puts "Success!"
