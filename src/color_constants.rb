# All predefined color values referencable by name.
module ColorConstants

  # return [Array] of Symbol values of valid color constants.
  def color_constants
    [
      :red,
      :green,
      :blue,
      :light_blue,
      :light_green,
      :orange,
      :yellow,
      :blue_green,
      :turquois,
      :purple,
      :pink,
      :rose,
      :gray
    ]
  end

  def white
    Color.new("#ffffff")
  end

  def black
    Color.new("#000000")
  end

  def red
    Color.new("#ff0000")
  end

  def green
    Color.new("#00ff00")
  end

  def blue
    Color.new("#0000ff")
  end

  def light_blue
    Color.new("#0080ff")
  end

  def light_green
    Color.new("#80ff00")
  end

  def orange
    Color.new("#ff8000")
  end

  def yellow
    Color.new("#ffff00")
  end

  def blue_green
    Color.new("#00ff80")
  end

  def turquois
    Color.new("#00ffff")
  end

  def purple
    Color.new("#7f00ff")
  end

  def pink
    Color.new("#ff00ff")
  end

  def rose
    Color.new("#ff007f")
  end

  def gray
    Color.new("#808080")
  end

end
