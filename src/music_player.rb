require 'java'
require 'java_music_player'

# A MusicPlayer is used to play audio files located at a given filepath.
# The MusicPlayer makes use the JavaMusicPlayer which is a Thread running in the background.
# Currently, the MusicPlayer can only play .wav audio files.
# It is possible to play a audo file in a loop or just once, suspend and resume the player,
# stop it, or shutting down the player.
# All this invokations are performed in a synchronized manner.
# The MusicPlayer is either used to play theme songs or sound effects.
class MusicPlayer

  # Create a new MusicPlayer instance that can play a given list of audio files.
  #
  # @param path_file_name_list [Array] a list of Strings depicting
  #   the audio file paths to songs that should be played.
  # @hint: Currently only .wav can be played by the MusicPlayer.
  #
  # @example Initialize a new MusicPlayer instance
  #   that can play tetris sound effects
  #
  #   path_file_name_list = {i
  #     :jump=>"audio/jump.wav",
  #     :explosion=>"audio/explosion.wav",
  #     :kick=>"audio/kick.wav"}
  #   }
  #   mp = MusicPlayer.new(path_file_name_list)
  #   kick_sound = audio_file_from_list(:kick)
  #   mp.run_player_for(kick_sound) # plays kick sound
  #   mp.run_player_loop_for(kick_sound) # plays kick sound in a endless loop
  #
  def initialize(path_file_name_list)
    @audio_file_list = path_file_name_list
    @keep_running = true
  end

  # terminate music thread:
  # end its loop, free its resources, wipe out process
  def shut_down
    @keep_running = false
    @mp.stop
    @mp.shut_down
  end

  # Number of audio files in internal audio list.
  #
  # @return [Integer] number of audio files.
  def audio_file_count
    @audio_file_list.length
  end

  # Retrieve an audio file from the audio file list for a given index.
  #
  # @param idx [Integer] or [Symbol] conforms to a valid key
  # for @audio_file_list
  def audio_file_from_list(idx)
    @audio_file_list[idx]
  end

  # Play a random song of this MusicPlayer in a endless loop.
  def play
    idx = rand(audio_file_count)
    audio_file = audio_file_from_list(idx)
    run_player_loop_for(audio_file)
  end

  # Pauses this MusicPlayer
  #
  # @info: Immediately suspends the running music player.
  def suspend
    @mp.pause
  end

  # Resumes this MusicPlayer.
  #
  # @info: Immediately suspends the running music player.
  def resume
    @mp.resume
  end

  protected

  # plays a given audio file an infinitly often using the JavaMusicPlayer
  #
  # @param audio_file [String] file path to target audio file that should be played.
  def run_player_loop_for(audio_file)
    @mp = JavaMusicPlayer.new(audio_file)
    @mp.play_loop
  end

  # plays a given audio file once using the JavaMusicPlayer
  #
  # @param audio_file [String] file path to target audio file that should be played.
  def run_player_for(audio_file)
    @mp = JavaMusicPlayer.new(audio_file)
    @mp.play
  end

end
