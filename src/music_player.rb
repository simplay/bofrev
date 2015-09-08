require 'java'
require 'java_music_player'

# MusicPlayer runs given list of music files as a background process that can be synchronized during runtime.
class MusicPlayer

  # @param path_file_name_list [Array] of Strings of song path- and filenames
  # @hint: (with extension) to desired audio file.
  # @return [Thread] reference to sound thread
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

  # Run game music player.
  def play
    idx = rand(audio_file_count)
    audio_file = audio_file_from_list(idx)
    run_player_loop_for(audio_file)
  end

  def suspend
    @mp.pause
  end

  def resume
    @mp.resume
  end

  protected

  # plays a given audio file an infinitly often using the JavaMusicPlayer
  def run_player_loop_for(audio_file)
    @mp = JavaMusicPlayer.new(audio_file)
    @mp.play_loop
  end

  # plays a given audio file once using the JavaMusicPlayer
  def run_player_for(audio_file)
    @mp = JavaMusicPlayer.new(audio_file)
    @mp.play
  end

end
