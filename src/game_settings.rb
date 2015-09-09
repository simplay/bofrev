require 'game_meta_data'
require 'system_information'
require_relative 'apps/tetris/tetris_meta_data'
require_relative 'apps/game_of_life/game_of_life_meta_data'
require_relative 'apps/sokoban/sokoban_meta_data'
require_relative 'apps/snake/snake_meta_data'
require_relative 'apps/pingpong/ping_pong_meta_data'
require_relative 'apps/demo_sprites/demo_sprites_meta_data'
require_relative 'apps/fractals/fractal_meta_data'

# Singleton class
class GameSettings
  include GameMetaData

  # @param arguments [Hash] of relevant data to derive game settings
  # @hing The following keys are currently handled:
  #   :selected_game #=> [Integer] current game
  #     See REEDME.md
  #
  #   :selected_mode #=> [Integer] selected debug mode
  #     0: normal running mode
  #     1: without running the music thread
  #     2: without running the ticker thread
  def initialize(arguments={})
    @selected_game = arguments[:game] || 1
    @selected_mode = arguments[:debug] || 0
    @game_meta_data = derive_game_model
  end

  def self.build_from(arguments={})
    if @game_settings.nil?
      @game_settings = GameSettings.new(arguments)
    end
    @game_settings
  end

  def game_meta_data
    @game_meta_data
  end

  def selected_game
    @selected_game
  end

  def selected_mode
    @selected_mode
  end

  def derive_game_model
    case @selected_game
    when 1
      TetrisMetaData
    when 2
      GameOfLifeMetaData
    when 3
      SokobanMetaData
    when 4
      SnakeMetaData
    when 5
      PingPongMetaData
    when 6
      FractalMetaData
    when 7
      DemoSpritesMetaData
    end
  end

  def self.canvas
    game_meta_data.canvas
  end

  def self.game_meta_data
    build_from.game_meta_data
  end

  def self.selected_gui
    game_meta_data.gui_type_as_sym
  end

  def self.gui_to_build
    game_meta_data.gui_type
  end

  def self.run_music?
    build_from.selected_mode < 1
  end

  def self.run_game_thread?
    build_from.selected_mode < 2
  end

  def self.game_map
    game_meta_data.game_map
  end

  def self.theme_list
    game_meta_data.theme_list
  end

  def self.sound_effect_list
    game_meta_data.sound_effect_list
  end

  def self.achievement_system
    game_meta_data.achievement_system
  end

  def self.achievement_system_sym
    game_meta_data.achievement_system_sym
  end

  def self.render_attributes
    game_meta_data.render_attributes
  end

  def self.allowed_controls
    game_meta_data.allowed_controls
  end

  def self.cell_size
    GameSettings.render_attributes[:cell_size]
  end

  def self.width_pixels
    GameSettings.render_attributes[:width_pixels]
  end

  def self.height_pixels
    GameSettings.render_attributes[:height_pixels]
  end

  def self.max_height
    GameSettings.render_attributes[:max_height]
  end

  def self.max_width
    GameSettings.render_attributes[:max_width]
  end

  def self.tics_per_second
    GameSettings.render_attributes[:tics_per_second]
  end

  def self.show_grid?
    grid_is_shown = GameSettings.render_attributes[:show_grid]
    grid_is_shown.nil? ? true : grid_is_shown
  end

  # Get top level folder name where the audio folder lies in.
  #
  # @hint: In case bofrev is called by its executable jar, there is an additional
  # namespace folder called 'bofrev'. Every folder of the bofrev folder is put into
  # this parent folder by the jar. When running bofrev from the code, there is no such parent
  # folder. This is why we return for this case the prefix ''.
  #
  # @return [String] 'bofrev/' if bofrev.jar is called and '' otherwise.
  def self.audio_filefolder_prefix
    SystemInformation.called_by_jar? ? 'bofrev/' : ''
  end

end
