# frozen_string_literal: true

require 'minitest/autorun'
require_relative './game_of_fish'

class GameOfFishTest < Minitest::Test
  def setup
    @implementations = %i[fish_population fish_population_better]
    @input = [3, 4, 3, 1, 2]
  end

  def test_iteration_after_18_days
    @implementations.each do |meth|
      assert_equal 26, send(meth, @input.dup, 18)
    end
  end

  def test_iteration_after_80_days
    @implementations.each do |meth|
      assert_equal 5934, send(meth, @input.dup, 80)
    end
  end

  def test_iteration_after_256_days
    assert_equal 26_984_457_539, fish_population_better(@input, 256)
  end
end
