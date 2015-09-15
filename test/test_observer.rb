require "test_helper"

class TestObserver < Minitest::Test

  class ARandomClass < Observer
  end

  class BRandomClass < Observer
  end

  # allow to fetch puts outputs
  def fetch_stdout(&block)
    begin
      old_stdout = $stdout
      $stdout = StringIO.new('','w')
      yield block
      $stdout.string
    ensure
      $stdout = old_stdout
    end
  end

  def test_properly_inherited
    arc = ARandomClass.new
    assert_respond_to(arc, :handle_event)
    assert_respond_to(arc, :handle_event_with)
    assert_raises(RuntimeError, "not implemented yet"){arc.handle_event}
    assert_raises(RuntimeError, "not implemented yet"){arc.handle_event_with(nil)}
  end

  def test_implementing_abstract_methods_works
    BRandomClass.class_eval do

      def handle_event
        puts "implemented 1"
      end

      def handle_event_with(message)
        puts "implemented 2"
      end
    end
    arc = BRandomClass.new
    out1 = fetch_stdout {arc.handle_event}
    out2 = fetch_stdout {arc.handle_event_with(nil)}
    assert_equal(out1.strip, "implemented 1")
    assert_equal(out2.strip, "implemented 2")
  end

end
