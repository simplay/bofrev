require "test_helper"

class TestJavaMusicPlayer < Minitest::Test

  def setup
    @jmp = JavaMusicPlayer.new("foo.wav")
    @jmp.init_player
  end

  def test_is_responding_to_expected_methods
    assert(@jmp.respond_to?(:pause))
    assert(@jmp.respond_to?(:resume))
    assert(@jmp.respond_to?(:play_loop))
    assert(@jmp.respond_to?(:play))
    assert(@jmp.respond_to?(:stop))
    assert(@jmp.respond_to?(:shut_down))
  end

  def test_initialize
    jmp = JavaMusicPlayer.new("foo.wav")
    assert_equal(TinySound.state, "init")
    assert_equal(jmp.file, GameSettings.audio_filefolder_prefix+"foo.wav")
    assert(jmp.runnable?)
  end

  def test_pause
    @jmp.pause
    assert_equal(@jmp.player.state, "pause")
    assert_equal(@jmp.runnable?, false)
  end

  def test_resume
    @jmp.resume
    assert_equal(@jmp.player.state, "resume")
    assert_equal(@jmp.runnable?, true)
  end

  def test_play_loop
    @jmp.play_loop
    assert_equal(@jmp.player.state, "play loop")
  end

  def test_play
    @jmp.play
    assert_equal(@jmp.player.state, "play")
  end

  def test_stop
    @jmp.stop
    assert_equal(@jmp.player.state, "stop")
  end

  def test_shut_down
    @jmp.shut_down
    assert_equal(TinySound.state, "shutdown")
  end

end
