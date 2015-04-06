# TODO rename this class. responsibility: assign flag what game,mode has been selected by user.
module Settings
  @mode = 0
  @selected_game = 1


  COLORS = %w(green blue red yellow orange)

  def self.selected_game
    @selected_game
  end

  def self.set_mode(flag)
    @mode = flag[:debug] unless flag[:debug].nil?
    @selected_game = flag[:game] unless flag[:game].nil?
  end

  def self.selected_gui
    if @mode == 1
      :tetris_gui
    else
      :gui
    end
  end

  def self.gui_to_build
    if @mode == 1
      TetrisGui
    else
      Gui
    end
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

end