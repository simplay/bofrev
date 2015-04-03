require_relative '../game_meta_data'
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

  def self.render_attributes
    {
        :cell_size => 25,
        :width_pixels => 15,
        :height_pixels => 15,
        :max_width => 240,
        :max_height => 600
    }
  end

end