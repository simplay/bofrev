class Ticker
  def initialize(game, map, pacer, target)
    @game = game
    @map = map
    @pacer = pacer
    @total_ticks = 0
    @finished = false
    @target = target
  end

  def start
    @thread = Thread.new do
      loop do
        @total_ticks += 1
        @map.process_ticker
        @game.notify_all_targets_of_type(@target)
        sleep(1.0 / @pacer.ticks_per_second) # sleep time in [s]
        break if finished?
      end
    end
    @thread.join if (RUBY_PLATFORM == "java")
    nil
  end

  def inc_speed
    @pacer.inc_speed
  end

  def total_elapsed_ticks
    @total_ticks
  end

  def dec_speed
    @pacer.dec_speed
  end

  def finished?
    @finished
  end

  def shut_down
    @finished = true
    @thread.exit unless @thread.nil?
  end

end
