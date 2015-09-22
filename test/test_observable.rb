require "test_helper"

class TestObservable < Minitest::Test
  def setup
    @ano = ANewObservable.new
    @aao = AaNewObserver.new("aa1")
    @abo = AbNewObserver.new("ab1")
    @ano.subscribe(@aao)
    @ano.subscribe(@abo)
  end

  def test_subscribe
    assert_equal(@ano.observers, [@aao, @abo])
    aao2 = AaNewObserver.new("aa2")
    @ano.subscribe(aao2)
    assert_equal(@ano.observers, [@aao, @abo, aao2])
    @ano.unsubscribe_one(aao2)
  end

  def test_notify_all
    assert_equal(@aao.state, "")
    assert_equal(@abo.state, "")
    @ano.notify_all
    assert_equal(@aao.state, "aa1: handle event")
    assert_equal(@abo.state, "ab1: handle event")
    @aao.flush; @abo.flush
  end

  def test_notify_all_with_message
    assert_equal(@aao.state, "")
    assert_equal(@abo.state, "")
    @ano.notify_all_with_message("foobar")
    assert_equal(@aao.state, "aa1: handle event with message foobar")
    assert_equal(@abo.state, "ab1: handle event with message foobar")
    @aao.flush; @abo.flush
  end

  def test_notify_all_of_type
    assert_equal(@aao.state, "")
    assert_equal(@abo.state, "")
    @ano.notify_all_targets_of_type(Utility.underscore(AaNewObserver.to_s).to_sym)
    assert_equal(@aao.state, "aa1: handle event")
    @ano.notify_all_targets_of_type(Utility.underscore(AbNewObserver.to_s).to_sym)
    assert_equal(@abo.state, "ab1: handle event")
    @aao.flush; @abo.flush
  end

  def test_notify_all_of_type_with_message
    assert_equal(@aao.state, "")
    assert_equal(@abo.state, "")
    @ano.notify_all_targets_of_type_with_message(Utility.underscore(AaNewObserver.to_s).to_sym, "foo")
    assert_equal(@aao.state, "aa1: handle event with message foo")
    @ano.notify_all_targets_of_type_with_message(Utility.underscore(AbNewObserver.to_s).to_sym, "bar")
    assert_equal(@abo.state, "ab1: handle event with message bar")
    @aao.flush; @abo.flush
  end

  def test_unsubscribe
    aao2 = AaNewObserver.new("aa2")
    @ano.subscribe(aao2)
    assert_equal(@ano.observers, [@aao, @abo, aao2])
    @ano.unsubscribe(Utility.underscore(AaNewObserver.to_s).to_sym)
    assert_equal(@ano.observers, [@abo])
    @aao = AaNewObserver.new("aa1")
    @ano.subscribe(@aa2)
  end

  def test_unsubscribe_one
    assert_equal(@ano.observers, [@aao, @abo])
    aao2 = AaNewObserver.new("aa2")
    @ano.subscribe(aao2)
    assert_equal(@ano.observers, [@aao, @abo, aao2])
    @ano.unsubscribe_one(aao2)
  end

  def test_observers_of_type
    assert_equal(@ano.observers_of_type(Utility.underscore(AaNewObserver.to_s).to_sym), [@aao])
    assert_equal(@ano.observers_of_type(Utility.underscore(AbNewObserver.to_s).to_sym), [@abo])
  end

end
