require 'game_settings'

if (RUBY_PLATFORM == 'java')
  require 'java'
  require 'java_music_player'
end

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
    if (RUBY_PLATFORM == "java")
      @mp.stop
    else
      @thread.exit
      wipe_out
    end
  end

  # Run game music player relying on *mplayer*.
  # @hint: In case mplayer is not installed, this thread runs silently.
  # @param effect_sound [Symbol] a hash key in SOUND_EFFECTS.
  def ruby_play(effect_sound)
    if GameSettings.run_music?
      @thread = Thread.new do
        run = "mplayer #{@sound_effects[effect_sound]} -vo x11 -framedrop -cache 16384 -cache-min 20/100"
        system(run)
      end
    end
    nil
  end

  def java_play(effect_sound)
    sound_file = @sound_effects[effect_sound]
    puts "FILE: #{sound_file}"
    @mp = JavaMusicPlayer.new(sound_file)
    @mp.play
  end

  def play(effect_sound)
    if (RUBY_PLATFORM == "java")
      java_play(effect_sound)
    else
      ruby_play(effect_sound)
    end
  end

  protected

  # kill all running mplayer processes brute force and clear console.
  def wipe_out
    system("ps aux | grep -i mplayer | awk {'print $2'} | xargs kill -9 | clear")
  end

end
