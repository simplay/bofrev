require_relative '../map'

class GameOfLifeMap < Map

  def initialize(game)
    super(game)
    update_grid
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
    raise "not implemented yet"
  end

  # defines how thicker should update this map.
  def process_ticker
    raise "not implemented yet"
  end

  private

  def update_grid
    @prev_iter_grid = @grid
  end


end