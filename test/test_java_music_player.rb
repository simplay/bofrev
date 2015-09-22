require "test_helper"

class TestJavaMusicPlayer < Minitest::Test

  def test_is_responding_to_expected_methods
    jmp = JavaMusicPlayer.new("foo.wav")
    assert(jmp.respond_to?(:pause))
    assert(jmp.respond_to?(:resume))
    assert(jmp.respond_to?(:play_loop))
    assert(jmp.respond_to?(:play))
    assert(jmp.respond_to?(:stop))
    assert(jmp.respond_to?(:shut_down))
  end

  def test_initialize
    jmp = JavaMusicPlayer.new("foo.wav")
    assert_equal(TinySound.state, "init")
    assert_equal(jmp.file, GameSettings.audio_filefolder_prefix+"foo.wav")
    assert(jmp.runnable?)
  end

end
