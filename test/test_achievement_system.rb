require "test_helper"

class TestAchievementSystem < Minitest::Test
  def setup
    FancyAchievementSystem.flush
    AchievementSystem.flush
  end

  def test_instance
    assert_equal(FancyAchievementSystem.internal_instance_object.nil?, true)
    assert_equal(AchievementSystem.internal_instance_object.nil?, true)
    assert_equal(AchievementSystem.instance.nil?, false)
    assert_equal(AchievementSystem.internal_instance_object.nil?, false)
    assert_equal(AchievementSystem.instance.is_a?(AchievementSystem), true)
    assert_equal(AchievementSystem.instance.class, AchievementSystem)
    assert_equal(FancyAchievementSystem.instance.is_a?(AchievementSystem), true)
    assert_equal(FancyAchievementSystem.instance.is_a?(FancyAchievementSystem), true)
    assert_equal(FancyAchievementSystem.instance.class, FancyAchievementSystem)
    assert_equal(FancyAchievementSystem.internal_instance_object.nil?, false)
  end

end
