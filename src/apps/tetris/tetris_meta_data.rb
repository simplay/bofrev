require 'game_meta_data'
require_relative 'tetris_achievement_system'
require_relative 'tetris_map'

class TetrisMetaData
  extend GameMetaData

  def self.theme_list
    ['audio/tetris_tone_loop.wav']
  end

  def self.sound_effect_list
    {
        :jump => "audio/jump.wav",
        :explosion => "audio/explosion.wav",
        :kick => "audio/kick.wav"
    }
  end

  def self.achievement_system
    TetrisAchievementSystem.instance
  end

  def self.game_map
    TetrisMap
  end

  def self.canvas
    FreeformCanvas
  end

  def self.render_attributes
    {
        :cell_size => 20,
        :width_pixels => 10,
        :height_pixels => 20,
        :max_width => 200,
        :max_height => 420,
        :tics_per_second => 1
    }
  end

  def self.gui_type
    View
  end

  def self.allowed_controls
    {
      :keyboard => [A_KEY, W_KEY, D_KEY, S_KEY],
      :mouse => []
    }
  end

end
