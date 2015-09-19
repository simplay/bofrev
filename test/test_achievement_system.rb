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
    FancyAchievementSystem.flush
  end

  def test_unlocking_meachnism
    FancyAchievementSystem.register(:foo)
    FancyAchievementSystem.register(:bar)
    assert(FancyAchievementSystem.all_unlocks.empty?)
    assert_equal(FancyAchievementSystem.last_unlock, "")
    FancyAchievementSystem.instance.update_list_for(:foo)
    assert_equal(FancyAchievementSystem.all_unlocks, ["foo"])
    assert_equal(FancyAchievementSystem.last_unlock, "foo")
    FancyAchievementSystem.instance.update_list_for(:bar)
    assert_equal(FancyAchievementSystem.all_unlocks, ["foo", "bar"])
    assert_equal(FancyAchievementSystem.last_unlock, "bar")
    FancyAchievementSystem.instance.update_list_for(:baz)
    assert_equal(FancyAchievementSystem.all_unlocks, ["foo", "bar"])
    assert_equal(FancyAchievementSystem.last_unlock, "bar")
    FancyAchievementSystem.register(:pew)
    assert_equal(FancyAchievementSystem.last_unlock, "bar")
    FancyAchievementSystem.instance.update_list_for(:pew)
    assert_equal(FancyAchievementSystem.all_unlocks, ["foo", "bar", "pew"])
    assert_equal(FancyAchievementSystem.last_unlock, "pew")
    FancyAchievementSystem.flush
  end

  def test_register_new_achievement
    assert_equal(FancyAchievementSystem.instance.achiev_list, {})
    FancyAchievementSystem.register(:foo)
    assert_equal(FancyAchievementSystem.instance.achiev_list, {:foo => false})
    FancyAchievementSystem.register(:foo)
    assert_equal(FancyAchievementSystem.instance.achiev_list, {:foo => false})
    FancyAchievementSystem.register(:bar)
    assert_equal(FancyAchievementSystem.instance.achiev_list, {:foo => false, :bar => false})
    FancyAchievementSystem.flush
  end

  def test_notification_handle
    assert_raises(RuntimeError, "not implemented yet"){AchievementSystem.instance.handle_event_with(nil)}
    AchievementSystem.flush
  end

end
