# TODO rename this class. responsibility: assign flag what game,mode has been selected by user.
module Settings
  @mode = 0
  @selected_game = 1

  def self.selected_game
    @selected_game
  end

  def self.set_mode(flag)
    @mode = flag[:debug] unless flag[:debug].nil?
    @selected_game = flag[:game] unless flag[:game].nil?
  end

  # TODO: refactor me: Make factory...
  def self.selected_gui
    return :freeform_gui if @selected_game == 7
    :tetris_gui
  end

  # TODO: Refactor me: Build a factory.
  def self.gui_to_build
    return FreeformGui if @selected_game == 7
    TetrisGui
  end


end
