require_relative '../game_meta_data'
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

end