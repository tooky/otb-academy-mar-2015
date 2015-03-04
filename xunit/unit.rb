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

class TestCase
  def initialize(name)
    @name = name
  end

  def setup
  end

  def run
    setup
    public_send(@name)
  end
end

class WasRun < TestCase
  attr_reader :was_run, :was_setup

  def setup
    @was_setup = true
  end

  def test_method
    @was_run = true
  end
end

class RunningTests < TestCase
  def test_a_test_method_is_invoked
    # a test method is invoked
    test = WasRun.new("test_method")
    test.run
    assert test.was_run
  end

  def test_setup_method_is_invoked
    # the setup method is invoked
    test = WasRun.new("test_method")
    test.run
    assert test.was_setup
  end
end

RunningTests.new("test_a_test_method_is_invoked").run
RunningTests.new("test_setup_method_is_invoked").run

puts "Success!"
