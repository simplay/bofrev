require 'game_meta_data'
require_relative 'game_of_life_map'

class GameOfLifeMetaData
  extend GameMetaData

  def self.theme_list
    []
  end

  def self.sound_effect_list
    {}
  end

  def self.achievement_system
    TetrisAchievementSystem.singleton
  end

  def self.achievement_system_sym
    :tetris_achievement_system
  end

  def self.game_map
    GameOfLifeMap
  end

  def self.canvas
    FreeformCanvas
  end

  def self.render_attributes
    {
        :cell_size => 5,
        :width_pixels => 40,
        :height_pixels => 80,
        :max_width => 194,
        :max_height => 450,
        :tics_per_second => 15
    }
  end

  def self.gui_type
    View
  end

  def self.allowed_controls
    {
      :keyboard => [A_KEY, S_KEY, W_KEY],
      :mouse => [LEFT_MOUSE_BUTTON_PRESSED, LEFT_MOUSE_BUTTON_DRAGGED]
    }
  end

end
