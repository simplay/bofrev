require 'color_constants'
require 'java'

# Color is a representation of 24 bit rgb colors.
# The value of every color is encoded in the format "#rrggbb"
# (i.e. a string prefixed by a '#' followed by its color channels).
# Every color channel is a hexdecimal number tupel represented as a string.
# Colors are used to draw colored pixels onto a canvas (See class Canvas).
class Color

  extend ColorConstants

  # @param rgb [String] 32bit RGB encoded as #rrggbb.
  def initialize(rgb)
    @rgb = rgb
    raise "invalide color encoding #{rgb}. Use '#rrggbb'" unless valid_encoding?
  end

  # Get rgb color value encoded as a color 24 string.
  #
  # @hint: A rgb color is formatted as '#rrggbb'.
  # @return [String] rgb string value.
  def to_rgb
    @rgb
  end

  # Get hexdecimal representation of the red color channel.
  #
  # @return [Integer] hex decimal Integer representation of red color channel
  def red_component
    components[1..2].join.to_i(16)
  end

  # Get hexdecimal representation of the green color channel.
  #
  # @return [Integer] hex decimal Integer representation of green color channel
  def green_component
    components[3..4].join.to_i(16)
  end

  # Get hexdecimal representation of the blue color channel.
  #
  # @return [Integer] hex decimal Integer representation of blue color channel
  def blue_component
    components[5..6].join.to_i(16)
  end

  # Translates this Color instance to a java awt color.
  #
  # @hint: Used for drawing onto a java canvas (i.e. a JFrame)
  # @return [Java::JavaAwt::Color] jruby Awt compatible color.
  def to_awt_color
    r_value = red_component.to_java(:int)
    g_value = green_component.to_java(:int)
    b_value = blue_component.to_java(:int)
    Java::JavaAwt::Color.new(r_value, g_value, b_value)
  end

  # Retrieve a random color from one of the known colors in ColorConstants
  #
  # @return [Color] a random color object.
  def self.next_random
    color_count = color_constants.count
    random_idx = rand(color_count)
    send(color_constants[random_idx])
  end

  # Compares the rgb color value between this and another color.
  #
  # @param other [Color] color to compare with this color's rgb value.
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
