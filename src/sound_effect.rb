require 'music_player'

class SoundEffect < MusicPlayer

  def initialize(sound_effects)
    super(sound_effects)
  end

  # Plays a target sound file ounce.
  # @param effect_sound [Symbol] key of target sound file that should be played.
  def play(effect_sound)
    sound_file = audio_file_from_list(effect_sound)
    run_player_for(sound_file)
  end

end
