require "minitest/autorun"
require 'color'
require 'java'
require 'pry'

class TestColor < Minitest::Test

  def setup
    # ensure that each channel has to digits (17 is first hex number having 2 digits)
    @red_channel_i = rand(17..256)
    @green_channel_i = rand(17..256)
    @blue_channel_i = rand(17..256)
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
    awt_color = Java::JavaAwt::Color.new(r_value, g_value, b_value)
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
     rgb_as_i = [@green_channel_i, @red_channel_i, @blue_channel_i]
     other_24_bit_rgb_value = "#"+(rgb_as_i.map {|chan| chan.to_s(16)}).join
     assert_equal(@random_color == Color.new(other_24_bit_rgb_value), false)
  end

end
