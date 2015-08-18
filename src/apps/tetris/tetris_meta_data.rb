require 'game_meta_data'
require_relative 'tetris_achievement_system'
require_relative 'tetris_map'

class TetrisMetaData
  include GameMetaData

  def self.theme_list
    ['audio/tetris_tone_loop.mp3']
  end

  def self.sound_effect_list
    {
        :jump => "audio/jump.mp3",
        :explosion => "audio/explosion.aiff",
        :kick => "audio/kick.wav"
    }
  end

  def self.achievement_system
    TetrisAchievementSystem.instance
  end

  def self.achievement_system_sym
    :tetris_achievement_system
  end

  def self.game_map
    TetrisMap
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
    GameMetaData.default_gui_or(GridGui)
  end

  def self.allowed_controls
    [A_KEY, W_KEY, D_KEY, S_KEY]
  end

end
