require "test_helper"
class TestSingletonable < Minitest::Test

  def test_singleton
    assert(ASingletonClass.respond_to?(:singleton))
    s1_oid = ASingletonClass.singleton.object_id
    s2_oid = ASingletonClass.singleton.object_id
    assert_equal(s1_oid, s2_oid)
  end

end
