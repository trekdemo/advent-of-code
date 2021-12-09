# frozen_string_literal: true

require 'minitest/autorun'
require_relative './smoke_simulator'

class SmokeSimulatorTest < Minitest::Test
  def setup
    @sim = SmokeSimulator.new(<<~HMAP)
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    HMAP
  end

  def test_low_points
    assert_equal(
      [[1, [1, 0]], [0, [9, 0]], [5, [2, 2]], [5, [6, 4]]],
      @sim.low_points
    )
  end

  def test_sum_risk_level
    assert_equal 15, @sim.sum_risk_level
  end
end
