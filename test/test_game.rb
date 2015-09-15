require "test_helper"
require 'event'

class TestGame < Minitest::Test

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

  def setup
    GameSettings.build_from
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

  def test_initialize
    game = Game.new
    assert_equal(game.started?, false)
    assert_equal(game.finished?, false)
    assert_equal(game.map.nil?, false)
    assert_equal(game.ticker_thread.nil?, false)
    assert_equal(game.music_thread.nil?, false)
    assert_equal(game.score.nil?, false)
    assert_includes(game.class, Observable)
    assert_includes(game.class, Waitable)
  end

  def test_update_score
    game = Game.new
    amount = rand
    prev_score = game.score.value
    game.update_score_by(amount)
    current_score = game.score.value
    assert_equal(prev_score+amount, current_score)
  end

  def test_perform_loop_step
    game = Game.new
    GameSettings.build_from
    out = fetch_stdout {game.perform_loop_step(Event.new(:killed, "foobar"))}
    assert(out.strip.include? "You scored #{game.score.final_points} point(s)!")
  end

end
