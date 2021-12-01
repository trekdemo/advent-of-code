# frozen_string_literal: true

require 'minitest/autorun'
require_relative './sonar'

# TestSonar - Advanced Submarine Sonar instrument
class TestSonar < Minitest::Test
  def setup
    @sonar = Sonar.new
  end

  def test_increase_count
    input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert_equal 7, @sonar.increase_count(input)
  end

  def test_three_increase_count
    input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert_equal 5, @sonar.three_increase_count(input)
  end
end
