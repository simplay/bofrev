module ClassAdaptions

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

  # overwridden View class initializer to not spawn a atw frame.
  View.class_eval do
    def initialize(game)
    end
  end

  Server.class_eval do
    def initialize
      puts "server is running"
    end
  end

  Client.class_eval do
    def initialize
      puts "client is running"
    end
  end

  # locally extend StystemInformation class such that different
  # caller cases and os environments can be mocked
  # by setting appropriate fields.
  SystemInformation.class_eval do

    # fake a target os by setting its fetched field.
    def set_os(os_name)
      @os = os_name
    end

    # fake a target caller by setting its fetched field.
    def set_caller(caller_name)
      @caller = caller_name
    end
  end

end
