require "minitest/autorun"
require 'color'

class TestColor < Minitest::Test

  def setup
    @random_24_bit_rgb_value = "#"+(3.times.map do rand(256).to_s(16) end).join
    @random_color = Color.new(@random_24_bit_rgb_value)
  end

  def test_to_rgb
    assert_equal(@random_color.to_rgb, @random_24_bit_rgb_value)
  end


end
