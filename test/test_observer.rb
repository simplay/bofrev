require "test_helper"

class TestObserver < Minitest::Test

  def test_properly_inherited
    arc = ARandomClass.new
    assert_respond_to(arc, :handle_event)
    assert_respond_to(arc, :handle_event_with)
    assert_raises(RuntimeError, "not implemented yet"){arc.handle_event}
    assert_raises(RuntimeError, "not implemented yet"){arc.handle_event_with(nil)}
  end

  def test_implementing_abstract_methods_works
    arc = BRandomClass.new
    out1 = fetch_stdout {arc.handle_event}
    out2 = fetch_stdout {arc.handle_event_with(nil)}
    assert_equal(out1.strip, "implemented 1")
    assert_equal(out2.strip, "implemented 2")
  end

end
