require "minitest/autorun"
require 'color'

class TestColor < Minitest::Test

  def setup
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
end
