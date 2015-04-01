module Settings
  @mode = 0

  MAX_WIDTH = 240
  MAX_HEIGHT = 600

  CELL_SIZE = 20
  WIDTH_PIXELS = 10

  HEIGHT_PIXELS = 20
  COLORS = %w(green blue red yellow orange)

  TICKS_PER_SECOND = 1 # determines the game speed.


  def self.achievement_system
    TetrisAchievementSystem.instance if @selected_game == 1
    TetrisAchievementSystem.instance if @selected_game == 2
  end

  def self.achievement_system_sym
    :tetris_achievement_system if @selected_game == 1
    :tetris_achievement_system if @selected_game == 2
  end

  def self.selected_game
    @selected_game
  end


  def self.set_mode(flag)
    @selected_game = 1

    @mode = flag[:debug] unless flag[:debug].nil?
    @selected_game = flag[:game] unless flag[:game].nil?
  end

  def self.run_music?
    @mode < 1
  end

  def self.run_game_thread?
    @mode < 2
  end

  def random_color
    idx = Random.rand(COLORS.length)
    COLORS[idx]
  end

  def x_pixels
    WIDTH_PIXELS + 2
  end

  def y_pixels
    HEIGHT_PIXELS + 2
  end

  def inner_x_pixels
    (MAX_WIDTH / CELL_SIZE)
  end

  def inner_y_pixels
    (MAX_HEIGHT / CELL_SIZE)
  end

  def x_iter
    (1..WIDTH_PIXELS)
  end

  def y_iter
    (1..HEIGHT_PIXELS)
  end

end