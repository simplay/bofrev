if (RUBY_PLATFORM == 'java')
  require 'java'
  java_import 'javafx.scene.media.Media'
  java_import 'javafx.scene.media.MediaPlayer'
end


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
    wipe_out
    return if (RUBY_PLATFORM == "java")
    @thread.exit
  end

  def java_play
    idx = rand(@song_list.length)
    song = @song_list[idx]
    hit = Media.new(song);
    media_player = MediaPlayer.new(hit)
    media_player.play
  end

  def ruby_play
    @thread = Thread.new do
      loop do
       break unless @keep_running
        idx = rand(@song_list.length)
        run = "mplayer #{@song_list[idx]} -vo x11 -framedrop -cache 16384 -cache-min 20/100"
        system(run)
      end
    end
    @thread.join if (RUBY_PLATFORM == "java")
    nil
  end

  # Run game music player relying on *mplayer*.
  # @hint: In case mplayer is not installed, this thread runs silently.
  def play
    if (RUBY_PLATFORM == "java")
      java_play
    else
      ruby_play
    end
  end

  protected

  # kill all running mplayer processes brute force and clear console.
  def wipe_out
    system("ps aux | grep -i mplayer | awk {'print $2'} | xargs kill -9 | clear")
  end

end
