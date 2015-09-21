require "test_helper"

class TestUtility < Minitest::Test

  def test_is_responding_to_expected_helpers
    assert(Utility.respond_to?(:underscore))
  end

  def test_underscore
    assert_equal(Utility.underscore("Foo"), "foo")
    assert_equal(Utility.underscore("FooBar"), "foo_bar")
    assert_equal(Utility.underscore("FooBarBaz"), "foo_bar_baz")
    assert_equal(Utility.underscore("AAA::FooBarBaz"), "aaa/foo_bar_baz")
    assert_equal(Utility.underscore("BBB::AAA::FooBarBaz"), "bbb/aaa/foo_bar_baz")
    assert_equal(Utility.underscore("Abc::Def::FooBarBaz"), "abc/def/foo_bar_baz")
  end

end
