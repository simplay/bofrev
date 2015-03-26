class Ticker
  def initialize(game, map, pacer)
    @game = game
    @map = map
    @pacer = pacer
    @finished = false
  end

  def start
    @thread = Thread.new do
      loop do
        @map.move_shape_one_down
        @game.notify_all_targets_of_type(:gui)
        sleep(1.0 / @pacer.ticks_per_second) # sleep time in [s]
        break if finished?
      end
    end
    nil
  end

  def finished?
    @finished
  end

  def shut_down
    @finished = true
    @thread.exit
  end

end