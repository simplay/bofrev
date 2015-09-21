require "test_helper"
class TestSingletonable < Minitest::Test

  def setup
    ASingletonClass.flush
  end

  def test_singleton
    assert(ASingletonClass.respond_to?(:singleton))
    s1_oid = ASingletonClass.singleton.object_id
    s2_oid = ASingletonClass.singleton.object_id
    assert_equal(s1_oid, s2_oid)
    ASingletonClass.flush
  end

  def test_singleton_instance
    assert_equal(ASingletonClass.singleton_instance.nil?, true)
    s1 = ASingletonClass.singleton
    assert_equal(ASingletonClass.singleton_instance.nil?, false)
    s2 = ASingletonClass.singleton
    assert_equal(s1.object_id, s2.object_id)
    ASingletonClass.flush
  end

  def test_flush
    assert_equal(ASingletonClass.singleton_instance.nil?, true)
    s1 = ASingletonClass.singleton
    assert_equal(ASingletonClass.singleton_instance.nil?, false)
    s2 = ASingletonClass.singleton
    assert_equal(s1.object_id, s2.object_id)
    ASingletonClass.flush
    assert_equal(ASingletonClass.singleton_instance.nil?, true)
    assert_equal(ASingletonClass.singleton_instance.nil?, true)
  end

end
