# xUnit

[xUnit][xunit-mf] is the family name for a group of unit testing frameworks following in the
tradition of `junit` - the original java unit testing framework. It has been
ported many times to many languages (including ruby).

Here is an example of what an xUnit like test case might look like in Ruby:

```ruby
require 'set'
class SetTest < TestCase
  def setup
    @empty = Set.new
  end

  def test_add
    @empty.add 5
    assert 1 == @empty.size
  end

  def test_add_same_element
    @empty.add 5
    @empty.add 5
    assert 1 == @empty.size
  end

  # Not needed here, but runs after every test
  def tear_down
  end
end
```

The key features are:

  * Each test is a method that starts with `test_`;
  * There is a setup method that can be overridden and will be called before
    each test;
  * Similarly, there is a `tear_down` method will be called after each test
    &mdash; useful for cleaning up resources, e.g. databases, files;
  * Each test is run indepently (isolated) from the others;

Your task in this exercise is to write a basic unit testing framework
test-first, from scratch. You should use the framework you are writing to
test-drive itself.

Before you dive into the code spend a few minutes with your pair thinking of the
list of tests that you might need for a testing framework. How are you going to
start testing if you don't have a test framework?

[xunit-mf]: http://www.martinfowler.com/bliki/Xunit.html
