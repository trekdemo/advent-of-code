# frozen_string_literal: true

require 'minitest/autorun'
require_relative './fuel_calculator'

class FuelCalcTest < Minitest::Test
  def setup
    @input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
  end

  def test_fuel1
    assert_equal(37, fuel1(@input))
  end
end
