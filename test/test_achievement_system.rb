require "test_helper"

class TestAchievementSystem < Minitest::Test

  def setup
    FancyAchievementSystem.flush
    AchievementSystem.flush
  end

  def test_instance
    assert_equal(FancyAchievementSystem.singleton_instance.nil?, true)
    assert_equal(AchievementSystem.singleton_instance.nil?, true)
    assert_equal(AchievementSystem.singleton.nil?, false)
    assert_equal(AchievementSystem.singleton_instance.nil?, false)
    assert_equal(AchievementSystem.singleton.is_a?(AchievementSystem), true)
    assert_equal(AchievementSystem.singleton.class, AchievementSystem)
    assert_equal(FancyAchievementSystem.singleton.is_a?(AchievementSystem), true)
    assert_equal(FancyAchievementSystem.singleton.is_a?(FancyAchievementSystem), true)
    assert_equal(FancyAchievementSystem.singleton.class, FancyAchievementSystem)
    assert_equal(FancyAchievementSystem.singleton_instance.nil?, false)
    FancyAchievementSystem.flush
  end

  def test_unlocking_meachnism
    FancyAchievementSystem.register(:foo)
    FancyAchievementSystem.register(:bar)
    assert(FancyAchievementSystem.all_unlocks.empty?)
    assert_equal(FancyAchievementSystem.last_unlock, "")
    FancyAchievementSystem.singleton.update_list_for(:foo)
    assert_equal(FancyAchievementSystem.all_unlocks, ["foo"])
    assert_equal(FancyAchievementSystem.last_unlock, "foo")
    FancyAchievementSystem.singleton.update_list_for(:bar)
    assert_equal(FancyAchievementSystem.all_unlocks, ["foo", "bar"])
    assert_equal(FancyAchievementSystem.last_unlock, "bar")
    FancyAchievementSystem.singleton.update_list_for(:baz)
    assert_equal(FancyAchievementSystem.all_unlocks, ["foo", "bar"])
    assert_equal(FancyAchievementSystem.last_unlock, "bar")
    FancyAchievementSystem.register(:pew)
    assert_equal(FancyAchievementSystem.last_unlock, "bar")
    FancyAchievementSystem.singleton.update_list_for(:pew)
    assert_equal(FancyAchievementSystem.all_unlocks, ["foo", "bar", "pew"])
    assert_equal(FancyAchievementSystem.last_unlock, "pew")
    FancyAchievementSystem.flush
  end

  def test_register_new_achievement
    assert_equal(FancyAchievementSystem.singleton.achiev_list, {})
    FancyAchievementSystem.register(:foo)
    assert_equal(FancyAchievementSystem.singleton.achiev_list, {:foo => false})
    FancyAchievementSystem.register(:foo)
    assert_equal(FancyAchievementSystem.singleton.achiev_list, {:foo => false})
    FancyAchievementSystem.register(:bar)
    assert_equal(FancyAchievementSystem.singleton.achiev_list, {:foo => false, :bar => false})
    FancyAchievementSystem.flush
  end

  def test_notification_handle
    assert_raises(RuntimeError, "not implemented yet"){AchievementSystem.singleton.handle_event_with(nil)}
    AchievementSystem.flush
  end

end
