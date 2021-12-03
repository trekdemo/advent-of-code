# frozen_string_literal: true

require 'minitest/autorun'
require_relative './diagnostics'

class TestDiagnostics < Minitest::Test
  def setup
    input = <<~INPUT
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    INPUT
    @diag = Diagnostics.new(input)
  end

  def test_gamma_rate
    assert_equal 22, @diag.gamma_rate
  end

  def test_epsilon_rate
    assert_equal 9, @diag.epsilon_rate
  end

  def test_power_consumption
    assert_equal 198, @diag.power_consumption
  end

  def test_oxigen_generator_rating
    assert_equal 23, @diag.oxigen_generator_rating
  end

  def test_co2_scrubber_rating
    assert_equal 10, @diag.co2_scrubber_rating
  end

  def test_lifesupport_rating
    assert_equal 230, @diag.lifesupport_rating
  end
end
