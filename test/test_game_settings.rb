require "minitest/autorun"

class TestGameSettings < Minitest::Test

  # Runs bofore every test, before teardown.
  # Flush GameSettings singleton before running a GameSettings test.
  def before_teardown
    GameSettings.flush
  end

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

  def test_derived_game_model_is_Tetris_for_g_1
    gs = GameSettings.new({:game => 1})
    assert_equal(gs.selected_game, 1)
    assert_equal(gs.derive_game_model, TetrisMetaData)
  end

  def test_derived_game_model_is_GameOfLife_for_g_2
    gs = GameSettings.new({:game => 2})
    assert_equal(gs.selected_game, 2)
    assert_equal(gs.derive_game_model, GameOfLifeMetaData)
  end

  def test_derived_game_model_is_Sokoban_for_g_3
    gs = GameSettings.new({:game => 3})
    assert_equal(gs.selected_game, 3)
    assert_equal(gs.derive_game_model, SokobanMetaData)
  end

  def test_derived_game_model_is_Snake_for_g_4
    gs = GameSettings.new({:game => 4})
    assert_equal(gs.selected_game, 4)
    assert_equal(gs.derive_game_model, SnakeMetaData)
  end

  def test_derived_game_model_is_PingPong_for_g_5
    gs = GameSettings.new({:game => 5})
    assert_equal(gs.selected_game, 5)
    assert_equal(gs.derive_game_model, PingPongMetaData)
  end

  def test_derived_game_model_is_Fractal_for_g_6
    gs = GameSettings.new({:game => 6})
    assert_equal(gs.selected_game, 6)
    assert_equal(gs.derive_game_model, FractalMetaData)
  end

  def test_derived_game_model_is_DemoSprites_for_g_7
    gs = GameSettings.new({:game => 7})
    assert_equal(gs.selected_game, 7)
    assert_equal(gs.derive_game_model, DemoSpritesMetaData)
  end

  def test_game_settings_flush
    gs = GameSettings.build_from({:debug => 0})
    assert_equal(gs.selected_mode, 0)
    gs = GameSettings.build_from({:debug => 1})
    assert(gs.selected_mode != 1)
    assert_equal(gs.selected_mode, 0)
    GameSettings.flush
    gs = GameSettings.build_from({:debug => 1})
    assert_equal(gs.selected_mode, 1)
  end

  def test_debug_mode_0_runs_all_threads
    GameSettings.build_from({:debug => 0})
    assert(GameSettings.run_music?)
    assert(GameSettings.run_game_thread?)
  end

  def test_debug_mode_1_runs_no_music_but_ticker
    gs = GameSettings.build_from({:debug => 1})
    assert_equal(GameSettings.run_music?, false)
    assert(GameSettings.run_game_thread?)
  end

  def test_debug_mode_2_runs_no_music_and_no_ticker
    gs = GameSettings.build_from({:debug => 2})
    assert_equal(GameSettings.run_music?, false)
    assert_equal(GameSettings.run_game_thread?, false)
  end
end
