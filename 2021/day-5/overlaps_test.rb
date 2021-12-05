# frozen_string_literal: true

require 'minitest/autorun'
require_relative './overlaps'

class TestOverlaps < Minitest::Test
  def setup
    input = File.read(File.expand_path('input-test.txt', __dir__))
    @overlaps = Overlaps.new(input)
  end

  def test_overlaps
    assert_equal 12, @overlaps.overlaps
  end
end
