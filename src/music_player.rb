require 'java'
require 'java_music_player'

# MusicPlayer runs given list of music files as a background process that can be synchronized during runtime.
class MusicPlayer

  # @param path_file_name_list [Array] of Strings of song path- and filenames
  # @hint: (with extension) to desired audio file.
  # @return [Thread] reference to sound thread
  def initialize(path_file_name_list)
    @song_list = path_file_name_list
    @keep_running = true
  end

  # terminate music thread:
  # end its loop, free its resources, wipe out process
  def shut_down
    @keep_running = false
    @mp.stop
  end

  # Run game music player.
  def play
    idx = rand(@song_list.length)
    song = @song_list[idx]
    @mp = JavaMusicPlayer.new(song)
    @mp.play_loop
  end

end
