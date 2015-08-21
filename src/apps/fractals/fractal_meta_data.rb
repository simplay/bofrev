require 'game_meta_data'
require_relative 'fractal_map'

class FractalMetaData
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
    FractalMap
  end

  def self.render_attributes
    {
      :cell_size => 1,
      :width_pixels => 400,
      :height_pixels => 400,
      :max_width => 400,
      :max_height => 400,
      :tics_per_second => 15
    }
  end

  def self.gui_type
    GameMetaData.default_gui_or(FractalView)
  end

end
