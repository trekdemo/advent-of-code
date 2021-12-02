# frozen_string_literal: true

require 'minitest/autorun'
require_relative './control'

class TestControl < Minitest::Test
  def setup
    input = <<~EOS
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    EOS
    @control = Control.new(input)
  end

  def test_execute_and_report
    assert_equal 900, @control.execute_and_report
  end
end
