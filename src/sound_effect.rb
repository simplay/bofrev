require 'game_settings'
require 'java'
require 'java_music_player'

class SoundEffect

  # Sounds
  SOUND_EFFECTS = {
      :jump => "audio/jump.mp3",
      :explosion => "audio/explosion.mp3",
      :kick => "audio/kick.mp3"
  }

  def initialize(sound_effects = SOUND_EFFECTS)
    @sound_effects = sound_effects
  end

  # terminate music thread:
  # end its loop, free its resources, wipe out process
  def shut_down
    @mp.stop
  end

  def play(effect_sound)
    sound_file = @sound_effects[effect_sound]
    @mp = JavaMusicPlayer.new(sound_file)
    @mp.play
  end

end
