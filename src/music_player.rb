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
    @thread.exit
    wipe_out
  end

  # Run game music player relying on *mplayer*.
  # @hint: In case mplayer is not installed, this thread runs silently.
  def play
    @thread = Thread.new do
      loop do
        idx = rand(@song_list.length)
        run = "mplayer #{@song_list[idx]} -vo x11 -framedrop -cache 16384 -cache-min 20/100"
        system(run)
        break unless @keep_running
      end
    end
    @thread.join
    nil
  end

  protected

  # kill all running mplayer processes brute force and clear console.
  def wipe_out
    system("ps aux | grep -i mplayer | awk {'print $2'} | xargs kill -9 | clear")
  end

end
