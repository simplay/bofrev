require 'color_constants'
class Color
  extend ColorConstants

  # @param rgb [String] 32bit RGB encoded as #rrggbb.
  def initialize(rgb)
    @rgb = rgb
    raise "invalide color encoding #{rgb}. Use '#rrggbb'" unless valid_encoding?
  end

  # @return [String] rgb string value.
  def to_rgb
    @rgb
  end

  def red_component
    components[1..2]
  end

  def green_component
    components[3..4]
  end

  def blue_component
    components[5..6]
  end

  def valid_encoding?
    (@rgb =~ /#(.){6}/) == 0
  end

  def self.next_random
    color_count = color_constants.count
    random_idx = rand(color_count)
    send(color_constants[random_idx])
  end

  # @param other [Color] another color value we want to compare with this.
  # @return [Boolean] true if both #to_rgb methods yield the same value.
  def ==(other)
    other.to_rgb == to_rgb
  end

  private

  def components
    @rgb.split(//)
  end

end
