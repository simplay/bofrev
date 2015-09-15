require "test_helper"

class TestGame < Minitest::Test
  def setup
    GameSettings.build_from
    Game.class_eval do
      def music_thread
        @music_thread
      end

      def score
        @score
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
end
