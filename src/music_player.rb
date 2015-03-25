class MusicPlayer

  # @param path_file_name [String] path and filename
  # (with extension) to desired audio file
  # @return [Thread] reference to sound thread
  def initialize(path_file_name)
    @path_file_name = path_file_name
    @keep_running = true
  end

  def shut_down
    @keep_running = false
    @thread.exit
    wipe_out
  end

  def play
    @thread = Thread.new do
      loop do
        run = "mplayer #{@path_file_name} -vo x11 -framedrop -cache 16384 -cache-min 20/100"
        @p_id = system(run)
        break unless @keep_running
      end
    end
    nil
  end

  protected

  # kill mplayer process brute force
  def wipe_out
    system("ps aux | grep -i mplayer | awk {'print $2'} | xargs kill -9 | clear")
  end

end
