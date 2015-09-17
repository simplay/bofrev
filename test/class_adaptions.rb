module ClassAdaptions

  # allow to fetch puts outputs
  def fetch_stdout(&block)
    begin
      old_stdout = $stdout
      $stdout = StringIO.new('','w')
      yield block
      $stdout.string
    ensure
      $stdout = old_stdout
    end
  end

  LayerManager.class_eval do
    def layers
      @layers
    end
  end

  Layer.class_eval do
    def drawables
      @drawables
    end

    def state
      @state
    end

    def update_drawables
      @state = "update #{self.object_id}"
    end

    def draw_drawables_onto(g)
      @state = "draw #{self.object_id}"
    end
  end

  Game.class_eval do
    def music_thread
      @music_thread
    end

    def score
      @score
    end

    def notify_all_targets_of_type(type)
    end

  end

  MusicPlayer.class_eval do
    def play
    end

    def shut_down
    end
  end

  Ticker.class_eval do
    def start
    end

    def shut_down
    end
  end

  Map.class_eval do
    def handle_ticker_notification
    end

    def handle_user_input_notification_for(msg)
    end
  end

end
