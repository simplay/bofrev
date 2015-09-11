require 'color_constants'
require 'java'

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
    components[1..2].join.to_i(16)
  end

  def green_component
    components[3..4].join.to_i(16)
  end

  def blue_component
    components[5..6].join.to_i(16)
  end

  # @return [Java::JavaAwt::Color] jruby Awt compatible color.
  def to_awt_color
    r_value = red_component.to_java(:int)
    g_value = green_component.to_java(:int)
    b_value = blue_component.to_java(:int)
    Java::JavaAwt::Color.new(r_value, g_value, b_value)
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

  # Splits the rgb string into its components
  #
  # @return [Array] containing the color string components.
  def components
    @rgb.split(//)
  end

  # Only accept 24 bit colors having the following encoding #rrggbb, where
  # 'r' is a 4bit number corresponding to the red color channel
  # 'g' is a 4bit number corresponding to the green color channel
  # 'b' is a 4bit number corresponding to the blue color channel
  # and '#' is an identifying color string prefix.
  #
  # @return [Boolean] true if encoding is correct and otherwise false.
  def valid_encoding?
    (@rgb =~ /#(.){6}/) == 0
  end

end
