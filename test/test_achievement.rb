require "test_helper"

class TestAchievement < Minitest::Test

  def test_initialize
    rule = lambda {}
    a = Achievement.new(:foo, rule)
    assert_equal(a.identifier, :foo)
  end

end
