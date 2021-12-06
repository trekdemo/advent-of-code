# frozen_string_literal: true

require 'minitest/autorun'
require_relative './game_of_fish'

class GameOfFishTest < Minitest::Test
  def setup
    @input = [3, 4, 3, 1, 2]
  end

  def test_iteration_after_18_days
    assert_equal 26, fish_population(@input, 18)
  end

  def test_iteration_after_80_days
    assert_equal 5934, fish_population(@input, 80)
  end

  # def test_iteration_after_256_days
  #   assert_equal 26_984_457_539, fish_population(@input, 256)
  # end
end
