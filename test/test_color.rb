require "test_helper"

class TestColor < Minitest::Test

  def setup
    # ensure that each channel has to digits (17 is first hex number having 2 digits)
    @red_channel_i = rand(17..255)
    @green_channel_i = rand(17..255)
    @blue_channel_i = rand(17..255)
    rgb_as_i = [@red_channel_i, @green_channel_i, @blue_channel_i]
    @random_24_bit_rgb_value = "#"+(rgb_as_i.map {|chan| chan.to_s(16)}).join
    @random_color = Color.new(@random_24_bit_rgb_value)
  end

  def test_to_rgb
    assert_equal(@random_color.to_rgb, @random_24_bit_rgb_value)
  end

  def test_red_component?
    assert_equal(@random_color.red_component, @red_channel_i)
  end

  def test_green_component?
    assert_equal(@random_color.green_component, @green_channel_i)
  end

  def test_blue_component?
    assert_equal(@random_color.blue_component, @blue_channel_i)
  end

  def test_to_awt_color
    r_value = @red_channel_i.to_i.to_java(:int)
    g_value = @green_channel_i.to_i.to_java(:int)
    b_value = @blue_channel_i.to_i.to_java(:int)
    constructor = Java::JavaAwt::Color.java_class.constructor(Java::int, Java::int, Java::int)
    awt_color = constructor.new_instance(r_value, g_value, b_value)
    assert_equal(@random_color.to_awt_color, awt_color)
  end

  def test_next_random
    color_constants = Color.color_constants.map do |color_name|
      Color.send(color_name)
    end
    next_random_from_color_const = color_constants.include?(Color.next_random)
    assert_equal(next_random_from_color_const, true)
  end

  def test_equality
     assert_equal(@random_color == @random_color, true)
     assert_equal(@random_color == Color.new(@random_24_bit_rgb_value), true)
     green_i = @green_channel_i

     # make sure that color values differ and are in range [17,255]
     if @green_channel_i==@red_channel_i
       if @green_channel_i == 17
         green_i = 18
       elsif @green_channel_i == 255
         green_i = 254
       else
          t = @green_channel_i / 2
          t = 17 if t < 17
          green_i = t
       end
     end
     rgb_as_i = [green_i, @red_channel_i, @blue_channel_i]
     other_24_bit_rgb_value = "#"+(rgb_as_i.map {|chan| chan.to_s(16)}).join
     assert_equal(@random_color == Color.new(other_24_bit_rgb_value), false)
  end

end
