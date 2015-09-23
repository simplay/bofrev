require 'game_settings'
require 'java'

require_relative '../lib/tinysound-1.1.1/tinysound-1.1.1.jar'
java_import 'kuusisto.tinysound.Music'
java_import 'kuusisto.tinysound.Sound'
java_import 'kuusisto.tinysound.TinySound'

# JavaMusicPlayer is Thread that wraps the TinySound java library used for playing
# .wav audio files.
# It is used by the MusicPlayer.
class JavaMusicPlayer

  # Create a new JavaMusicPlayer instance
  #
  # @param file [String] name and extension of target audio file that should
  # be played.
  def initialize(file)
    return if file.nil?
    @file = GameSettings.audio_filefolder_prefix+file
    @is_runnable = true
    TinySound.init
  end

  # Pauses this audio player playing its audio file.
  def pause
    @is_runnable = false
    @audio_file.pause
  end

  # Resumes playing a song of this audio player.
  #
  # @hint: Only call this method if the player was paused.
  def resume
    @audio_file.resume
    @is_runnable = true
  end

  # Play the given audio file in a loop.
  def play_loop
    start_player(:loop)
  end

  # Play the given audio file once.
  def play
    start_player(:once)
  end

  # Stops Streaming the audio file.
  def stop
    @audio_file.stop
  end

  # Shut down TinySound process.
  def shut_down
    TinySound.shutdown
  end

  protected

  # Wrapper for stating the TinySound based music player within its
  # own Thread.
  #
  # @param running_mode [Symbol] run mode for music player.
  #   :loop play the audio file in a loop.
  #   :once play the audio file once.
  def start_player(running_mode)
    @thread = Thread.new do
      run_sample(running_mode)
    end
  end

  # Run appropriate TinySound music player mode for playing an audio file.
  #
  # @param running_mode [Symbol] run mode for music player.
  #   :loop play the audio file in a loop.
  #   :once play the audio file once.
  def run_sample(running_mode)
    if running_mode == :loop
      @audio_file = TinySound.loadMusic(@file)
      @audio_file.play(true)
    else
      @audio_file = TinySound.loadSound(@file)
      @audio_file.play
    end
    sleep 0.5
  end

end
