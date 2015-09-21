require "test_helper"
require 'game_settings'

class TestMap < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_initialize
    gs = GameSettings.singleton
    map = GameSettings.game_map.new(@game)
    grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels,
                     GameSettings.show_grid?)
    assert_equal(map.grid.total_width, grid.total_width)
    assert_equal(map.grid.total_height, grid.total_height)
  end

end
