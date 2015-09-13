require "minitest/autorun"

class TestGameSettings < Minitest::Test

  def test_default_settings_selected_game_is_one
    assert_equal(GameSettings.build_from.selected_game, 1)
  end

  def test_default_settings_selected_mode_is_zero
    assert_equal(GameSettings.build_from.selected_mode, 0)
  end

  def test_default_settings_game_model_is_tetris
    assert_equal(GameSettings.build_from.derive_game_model, TetrisMetaData)
  end

  def test_default_settings_game_thread_is_running
    assert(GameSettings.run_game_thread?)
  end

  def test_default_settings_music_is_running
    assert(GameSettings.run_music?)
  end

end
