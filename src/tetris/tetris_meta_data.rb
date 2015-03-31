require_relative '../game_meta_data'
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

end