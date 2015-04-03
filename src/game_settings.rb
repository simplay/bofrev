require_relative 'settings'
require_relative 'game_meta_data'
require_relative 'tetris/tetris_meta_data'
require_relative 'game_of_life/game_of_life_meta_data'
require_relative 'sokoban/sokoban_meta_data'

module GameSettings
  include Settings
  include GameMetaData

  def self.build
    if @game.nil?
      if Settings.selected_game == 1
        @game = TetrisMetaData
      elsif Settings.selected_game == 2
        @game = GameOfLifeMetaData
      elsif Settings.selected_game == 3
        @game = SokobanMetaData
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


  def x_pixels
    width_pixels + 2
  end

  def y_pixels
    height_pixels + 2
  end

  def inner_x_pixels
    (max_width / cell_size)
  end

  def inner_y_pixels
    (max_height / cell_size)
  end

  def x_iter
    (1..width_pixels)
  end

  def y_iter
    (1..height_pixels)
  end


end