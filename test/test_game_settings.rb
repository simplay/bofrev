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

  def test_game_meta_data_is_correctly_build_for_selected_game
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data, rand_game_settings.derive_game_model)
  end

  def test_canvas_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.canvas, GameSettings.canvas)
  end

  def test_selected_gui_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.gui_type_as_sym, GameSettings.selected_gui)
  end

  def test_gui_to_build_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.gui_type, GameSettings.gui_to_build)
  end

  def test_game_map_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.game_map, GameSettings.game_map)
  end

  def test_theme_list_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.theme_list, GameSettings.theme_list)
  end

  def test_sound_effect_list_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.sound_effect_list,
                 GameSettings.sound_effect_list)
  end

  def test_achievement_system_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.achievement_system,
                 GameSettings.achievement_system)
  end

  def test_achievement_system_sym_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.achievement_system_sym,
                 GameSettings.achievement_system_sym)
  end

  def test_render_attributes_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.render_attributes,
                 GameSettings.render_attributes)
  end

  def test_allowed_controls_is_from_game_meta_data
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.allowed_controls,
                 GameSettings.allowed_controls)
  end

  def test_cell_size_is_from_render_attributes
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.render_attributes[:cell_size],
                 GameSettings.cell_size)
  end

  def test_width_pixels_is_from_render_attributes
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.render_attributes[:width_pixels],
                 GameSettings.width_pixels)
  end

  def test_height_pixels_is_from_render_attributes
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.render_attributes[:height_pixels],
                 GameSettings.height_pixels)
  end

  def test_max_height_is_from_render_attributes
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.render_attributes[:max_height],
                 GameSettings.max_height)
  end

  def test_max_width_is_from_render_attributes
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.render_attributes[:max_width],
                 GameSettings.max_width)
  end

  def test_tics_per_second_is_from_render_attributes
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.render_attributes[:tics_per_second],
                 GameSettings.tics_per_second)
  end

  def test_show_grid_is_from_render_attributes
    rand_game_idx = rand(1..7) # any available game
    rand_game_settings = GameSettings.build_from({:game => rand_game_idx})
    assert_equal(rand_game_settings.game_meta_data.render_attributes[:show_grid] || true,
                 GameSettings.show_grid?)
  end

  def test_show_grid_nil_case_do_show
    rand_game_settings = GameSettings.build_from({:game => 6})
    assert_equal(GameSettings.show_grid?, true)
  end

  def test_show_grid_true_case_do_show
    rand_game_settings = GameSettings.build_from({:game => 1})
    assert_equal(GameSettings.show_grid?, true)
  end

  def test_show_grid_false_case_dont_show
    rand_game_settings = GameSettings.build_from({:game => 7})
    assert_equal(GameSettings.show_grid?, false)
  end

  def test_audio_filefolder_prefix
    assert_equal(SystemInformation.called_by_jar? ? 'bofrev/' : '',
                 GameSettings.audio_filefolder_prefix)
  end

  def test_canvas_offsets
    on_windows = SystemInformation.running_on_windows?
    x = on_windows ? 6 : 1
    assert_equal(GameSettings.canvas_offsets, [x, 45])
  end

  def test_canvas_width
    assert_equal(GameSettings.canvas_width,
                 GameSettings.canvas_offsets[0]+GameSettings.max_width)
  end

  def test_canvas_height
    assert_equal(GameSettings.canvas_height,
                 GameSettings.canvas_offsets[1]+GameSettings.max_height)
  end

end
