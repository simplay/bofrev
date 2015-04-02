require_relative '../map'
require_relative '../game_settings'

class SokobanMap < Map

  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(WIDTH_PIXELS, HEIGHT_PIXELS)
    @mutex = Mutex.new

    initialize_map

  end

  # defines how user input should be handled to update the game state.
  def process_event(message)


    if message.type == 'd'
      pp = @player.value
      new_pp = Point2f.new(pp.x+1, pp.y)
      handle_update(new_pp, pp, Point2f.new(1,0))

    elsif message.type == 'a'
      pp = @player.value
      new_pp = Point2f.new(pp.x-1, pp.y)
      handle_update(new_pp, pp,Point2f.new(-1,0))

    elsif message.type == 's'
      pp = @player.value
      new_pp = Point2f.new(pp.x, pp.y+1)
      handle_update(new_pp, pp, Point2f.new(0,+1))


    elsif message.type == 'w'
      pp = @player.value
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
      set_entities(@chest.value.x+del.x, @chest.value.y+del.y)
      @player = @grid.field_at(new_pp.x, new_pp.y)
      @player.color = 'red'
      @player.value = Point2f.new(new_pp.x, new_pp.y)
      reset_player_pos_at(pp)
    elsif hit_target?(new_pp)

    else

      @player = @grid.field_at(new_pp.x, new_pp.y)
      @player.color = 'red'
      @player.value = Point2f.new(new_pp.x, new_pp.y)
      reset_player_pos_at(pp)
      set_entities(@chest.value.x, @chest.value.y)
    end

  end

  def reset_player_pos_at(pp)
    old_p = @grid.field_at(pp.x, pp.y)
    old_p.color = 'white'
    old_p.value = nil
  end

  def set_entities(x=8, y=8)
    @chest = @grid.field_at(x, y)
    @chest.color = 'blue'
    @chest.value = Point2f.new(x,y)

    @target = @grid.field_at(6, 7)
    @target.color = 'green'
    @target.value = Point2f.new(6,7)

    if hit_target?(@chest.value)
      initiate_game_over
    end
    
  end


  def hist_chest?(point)
    point == @chest.value
  end

  def hit_target?(point)
    point.x == @target.value.x && point.y == @target.value.y
  end

  def initialize_map
    @player = @grid.field_at(5,5)
    @player.color = 'red'
    @player.value = Point2f.new(5,5)

    set_entities

  end

  def update_grid

    puts "updates on: #{@allow_updates}"
  end

end