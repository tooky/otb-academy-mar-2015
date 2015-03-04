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
  attr_reader :was_run, :was_setup, :was_torn_down

  def setup
    @was_setup = true
  end

  def test_method
    @was_run = true
  end

  def tear_down
    @tear_down = true
  end
end

class RunningTests < TestCase
  def test_run_template_method
    test = WasRun.new("test_method")
    test.run
    assert [:setup, :test_method, :tear_down] == test.log
  end

  def test_result
    test = WasRun.new("test_method")
    result = test.run
    assert "1 run, 0 failed" == result.summary
  end
end

RunningTests.new("test_a_test_method_is_invoked").run
RunningTests.new("test_setup_method_is_invoked").run

puts "Success!"
