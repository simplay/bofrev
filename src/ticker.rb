require 'event'

class Ticker

  def initialize(game, pacer)
    @game = game
    @pacer = pacer
    @total_ticks = 0
    @finished = false
  end

  def start
    @thread = Thread.new do
      loop do
        break if @game.finished?
        @total_ticks += 1
        @game.perform_loop_step(Event.new(:ticker, "tc: #{@total_ticks}"))
        sleep(@pacer.idle_time)
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
    return if (RUBY_PLATFORM == "java")
    @thread.exit unless @thread.nil?
  end

end
