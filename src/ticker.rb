require 'event'

class Ticker

  def initialize(game, pacer)
    @game = game
    @pacer = pacer
    @total_ticks = 0
    @finished = false
  end

  def start
    return nil unless @pacer.running?
    @thread = Thread.new do
      loop do
        suspend if @game.paused?
        break if finished?
        @total_ticks += 1
        @game.perform_loop_step(Event.new(:ticker, "tc: #{@total_ticks}"))
        sleep(@pacer.idle_time)
      end
    end
    @thread.join
    nil
  end

  # let this ticker thread wait on the game conditional lock.
  def suspend
    @game.mutex.synchronize do
      @game.barrier.wait(@game.mutex)
    end
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
  end

end
