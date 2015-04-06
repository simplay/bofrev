require_relative '../game_meta_data'
require_relative 'ping_pong_map'

class PingPongMetaData
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
    PingPongMap
  end

  def self.render_attributes
    {
        :cell_size => 15,
        :width_pixels => 40,
        :height_pixels => 20,
        :max_width => 600,
        :max_height => 340,
        :tics_per_second => 15
    }
  end

end