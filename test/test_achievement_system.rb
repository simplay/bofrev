require "test_helper"

class TestAchievementSystem < Minitest::Test
  def test_instance
    assert_equal(AchievementSystem.instance.nil?, false)
    assert_equal(AchievementSystem.instance.is_a?(AchievementSystem), true)
    assert_equal(AchievementSystem.instance.class, AchievementSystem)
    assert_equal(FancyAchievementSystem.instance.is_a?(AchievementSystem), true)
    assert_equal(FancyAchievementSystem.instance.is_a?(FancyAchievementSystem), true)
    assert_equal(FancyAchievementSystem.instance.class, FancyAchievementSystem)
  end

end
