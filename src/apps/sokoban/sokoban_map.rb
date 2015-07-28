require_relative '../../map'
require_relative '../../game_settings'
require_relative '../../color'
require_relative 'level_parser'

class SokobanMap < Map

  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @mutex = Mutex.new

    lp = LevelParser.new(@grid, 'lvl1')

    @player = lp.player
    @chest = lp.chest
    @target = lp.target

    @chest_init_pos = @chest.value
    @target_init_pos = @target.value

  end

  # defines how user input should be handled to update the game state.
  def process_event(message)

    pp = @player.value
    if message.type == 'd'
      new_pp = Point2f.new(pp.x+1, pp.y)
      handle_update(new_pp, pp, Point2f.new(1,0))

    elsif message.type == 'a'
      new_pp = Point2f.new(pp.x-1, pp.y)
      handle_update(new_pp, pp,Point2f.new(-1,0))

    elsif message.type == 's'
      new_pp = Point2f.new(pp.x, pp.y+1)
      handle_update(new_pp, pp, Point2f.new(0,1))

    elsif message.type == 'w'
      new_pp = Point2f.new(pp.x, pp.y-1)
      handle_update(new_pp, pp, Point2f.new(0,-1))
    end

  end

  # does nothing
  def process_ticker
  end

  private

  def handle_update(new_pp, pp, del)

    if hist_chest?(new_pp)
      unless hit_wall?(Point2f.new(@chest.value.x+del.x, @chest.value.y+del.y))
        set_entities(@chest.value.x+del.x, @chest.value.y+del.y)
        @player = @grid.field_at(new_pp.x, new_pp.y)
        @player.color = Color.red
        @player.value = Point2f.new(new_pp.x, new_pp.y)
        reset_player_pos_at(pp)
      end
    elsif hit_target?(new_pp)

    elsif !hit_wall?(new_pp)
      @player = @grid.field_at(new_pp.x, new_pp.y)
      @player.color = Color.red
      @player.value = Point2f.new(new_pp.x, new_pp.y)
      reset_player_pos_at(pp)
      set_entities(@chest.value.x, @chest.value.y)
    end

  end

  def reset_player_pos_at(pp)
    old_p = @grid.field_at(pp.x, pp.y)
    old_p.color = Color.white
    old_p.value = nil
  end

  def set_entities(x, y)
    @chest = @grid.field_at(x, y)
    @chest.color = Color.blue
    @chest.value = Point2f.new(x,y)

    reset_target

    if hit_target?(@chest.value)
      initiate_game_over
    end

  end

  def reset_target
    @target = @grid.field_at(@target_init_pos.x, @target_init_pos.y)
    @target.color = Color.green
    @target.value = Point2f.new(@target_init_pos.x,@target_init_pos.y)
  end

  def hist_chest?(point)
    point == @chest.value
  end

  def hit_wall?(point)
    @grid.field_at(point.x, point.y).border?
  end

  def hit_target?(point)
    point.x == @target.value.x && point.y == @target.value.y
  end

end
