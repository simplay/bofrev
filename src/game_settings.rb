require_relative 'settings'
require_relative 'game_meta_data'
require_relative 'apps/tetris/tetris_meta_data'
require_relative 'apps/game_of_life/game_of_life_meta_data'
require_relative 'apps/sokoban/sokoban_meta_data'
require_relative 'apps/snake/snake_meta_data'
require_relative 'apps/pingpong/ping_pong_meta_data'
require_relative 'apps/demo_sprites/demo_sprites_meta_data'
require_relative 'views/tetris_gui'
require_relative 'freeform_gui'

# Singleton class
class GameSettings
  include Settings
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
    @selected_game = arguments[:game]
    @selected_mode = arguments[:debug]
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
    when 7
      DemoSpritesMetaData
    end
  end

  def self.game_meta_data
    build_from.game_meta_data
  end

  # TODO: refactor me: encode in meta data
  def self.selected_gui
    selected_game = build_from.selected_game
    (selected_game == 7) ? :freeform_gui : :tetris_gui
  end

  # TODO: refactor me: derive from selected gui (apply constantize)
  def self.gui_to_build
    selected_game = build_from.selected_game
    (selected_game == 7) ? FreeformGui : TetrisGui
  end

  def self.run_music?
    build_from.selected_mode < 1
  end

  def self.run_game_thread?
    build_from.selected_mode < 2
  end

  def self.build
    if @game.nil?
      if Settings.selected_game == 1
        @game = TetrisMetaData
      elsif Settings.selected_game == 2
        @game = GameOfLifeMetaData
      elsif Settings.selected_game == 3
        @game = SokobanMetaData
      elsif Settings.selected_game == 4
        @game = SnakeMetaData
      elsif Settings.selected_game == 5
        @game = PingPongMetaData
      elsif Settings.selected_game == 7
        @game = DemoSpritesMetaData
      end
    end
    @game
  end

  def self.game_map
    build.game_map
  end

  def self.theme_list
    build.theme_list
  end

  def self.sound_effect_list
    build.sound_effect_list
  end

  def self.achievement_system
    build.achievement_system
  end

  def self.achievement_system_sym
    build.achievement_system_sym
  end

  def self.render_attributes
    build.render_attributes
  end

  def cell_size
    GameSettings.render_attributes[:cell_size]
  end

  def self.cell_size
    GameSettings.render_attributes[:cell_size]
  end

  def width_pixels
    GameSettings.render_attributes[:width_pixels]
  end

  def self.width_pixels
    GameSettings.render_attributes[:width_pixels]
  end

  def height_pixels
    GameSettings.render_attributes[:height_pixels]
  end

  def self.height_pixels
    GameSettings.render_attributes[:height_pixels]
  end

  def max_height
    GameSettings.render_attributes[:max_height]
  end

  def self.max_height
    GameSettings.render_attributes[:max_height]
  end

  def max_width
    GameSettings.render_attributes[:max_width]
  end

  def self.max_width
    GameSettings.render_attributes[:max_width]
  end

  def self.tics_per_second
    GameSettings.render_attributes[:tics_per_second]
  end

  def tics_per_second
    GameSettings.render_attributes[:tics_per_second]
  end

  def self.gui_type
    GameSettings.render_attributes[:gui_type]
  end

  def gui_type
    GameSettings.render_attributes[:gui_type]
  end

end
