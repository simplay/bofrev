require "test_helper"
require 'event'

class TestGame < Minitest::Test

  def setup
    GameSettings.singleton
  end

  def before_teardown
    GameSettings.flush
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
    GameSettings.singleton
    game.music_player.assign_mp
    out = fetch_stdout {game.perform_loop_step(Event.new(:killed, "foobar"))}
    assert(out.strip.include? "You scored #{game.score.final_points} point(s)!")
  end

end
