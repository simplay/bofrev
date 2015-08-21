require 'game_meta_data'
require_relative 'sokoban_map'
require_relative '../tetris/tetris_achievement_system'

class SokobanMetaData
  include GameMetaData

  def self.theme_list
    []
  end

  def self.sound_effect_list
    {}
  end

  def self.achievement_system
    TetrisAchievementSystem.instance
  end

  def self.achievement_system_sym
    :tetris_achievement_system
  end

  def self.game_map
    SokobanMap
  end

  def self.canvas
    GridCanvas
  end

  def self.render_attributes
    {
        :cell_size => 25,
        :width_pixels => 20,
        :height_pixels => 13,
        :max_width => 500,
        :max_height => 345,
        :tics_per_second => 1
    }
  end

  def self.gui_type
    GameMetaData.default_gui_or(GridGui)
  end

  def self.allowed_controls
    {
      :keyboard => [D_KEY, A_KEY, S_KEY, W_KEY],
      :mouse => []
    }
  end

end
