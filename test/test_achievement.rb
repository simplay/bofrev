require "test_helper"

class TestAchievement < Minitest::Test

  def test_initialize
    rule = lambda {}
    a = Achievement.new(:foo, rule)
    assert_equal(a.identifier, :foo)
  end

  def test_initialize_raises_exception_when_rule_is_not_a_block
    rule = 3
    raised_text = "rule is not of type Proc but is equal #{rule.inspect}"
    assert_raises(RuntimeError, raised_text){Achievement.new(:bar, rule)}
  end

  def test_achieved_must_be_false_initially
    rule = lambda {|x| true}
    a = Achievement.new(:foo, rule)
    assert_equal(a.achieved?, false)
  end

  def test_achieved_must_be_true_after_evaluated_true
    rule = lambda {|x| true}
    a = Achievement.new(:foo, rule)
    assert_equal(a.achieved?, false)
    a.check_rule(true)
    assert_equal(a.achieved?, true)
  end

  def test_check_rule_yields_result
    rule = lambda {|x| x}
    a = Achievement.new(:foo, rule)
    assert_equal(a.achieved?, false)
    assert_equal(a.check_rule(false), false)
    assert_equal(a.check_rule(true), true)
  end

  def test_once_check_rule_was_true_it_remains_true_no_matter_what_is_passed_latter
    rule = lambda {|x| x > 1}
    a = Achievement.new(:foo, rule)
    assert_equal(a.achieved?, false)
    a.check_rule(2)
    assert_equal(a.achieved?, true)
    a.check_rule(-1)
    assert_equal(a.achieved?, true)
  end
end
