require "test_helper"

class TestEvent < Minitest::Test

  def test_initialize_default_content_is_nil
    type = :foobar
    e = Event.new(type)
    assert_equal(e.type, type)
    assert_equal(e.content, nil)
  end

  def test_initialize_assigns_correctly
    type = :foobar; content = 2
    e = Event.new(type, content)
    assert_equal(e.type, type)
    assert_equal(e.content, content)
  end

  def test_to_s
    type = :foobar; content = 2
    e = Event.new(type, content)
    assert_equal(e.to_s, "type: #{e.type} content: #{e.content}")
  end

end
