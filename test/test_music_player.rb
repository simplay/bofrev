require "test_helper"
require 'pry'
class TestMusicPlayer < Minitest::Test

  def test_initialize
    song_list = {:a1 => "audio/foo.wav"}
    mp = MusicPlayer.new(song_list)
    assert_equal(song_list, mp.audio_file_list)
    assert_equal(mp.keep_running, true)
  end

  def test_shut_down
    song_list = {:a1 => "audio/foo.wav"}
    mp = MusicPlayer.new(song_list)
    mp.assign_mp
    mp.shut_down
    assert_equal(mp.keep_running, false)
    assert_equal(mp.mp.state, "shut down")
  end

  def test_audio_file_count
    song_list = {:a1 => "audio/foo.wav"}
    mp = MusicPlayer.new(song_list)
    assert_equal(mp.audio_file_count, 1)
    song_list = {:a1 => "audio/foo.wav", :a2 => "foo/bar.wav"}
    mp = MusicPlayer.new(song_list)
    assert_equal(mp.audio_file_count, 2)
  end

  def test_audio_file_from_list
    song_list = {:a1 => "audio/foo.wav", :a2 => "audio/bar.wav"}
    mp = MusicPlayer.new(song_list)
    assert_equal(mp.audio_file_from_list(:a1), "audio/foo.wav")
    assert_equal(mp.audio_file_from_list(:a2), "audio/bar.wav")
  end

  def test_play
    song_list = {:a1 => "audio/foo.wav"}
    mp = MusicPlayer.new(song_list)
    mp.assign_mp
    mp.play
    assert_equal(mp.mp.state, "play loop")
  end

  def test_suspend
    song_list = {:a1 => "audio/foo.wav"}
    mp = MusicPlayer.new(song_list)
    mp.assign_mp
    mp.suspend
    assert_equal(mp.mp.state, "pause")
  end

  def test_resume
    song_list = {:a1 => "audio/foo.wav"}
    mp = MusicPlayer.new(song_list)
    mp.assign_mp
    mp.resume
    assert_equal(mp.mp.state, "resume")
  end

end
