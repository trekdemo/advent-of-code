# frozen_string_literal: true

require 'minitest/autorun'
require_relative './polimerization'

# PolimerizationTest ...
class PolimerizationTest < Minitest::Test
  INPUT = <<~INPUT
    NNCB

    BB -> N
    BC -> B
    BH -> H
    BN -> B
    CB -> H
    CC -> N
    CH -> B
    CN -> C
    HB -> C
    HC -> B
    HH -> N
    HN -> C
    NB -> B
    NC -> B
    NH -> C
    NN -> C
  INPUT
  STEPS = %w[
    NCNBCHB
    NBCCNBBBCBHCB
    NBBBCNCCNBBNBNBBCHBHHBCHB
    NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB
  ].freeze

  def test_polimerization_steps
    p = Polimerization.new(INPUT)
    STEPS.each_with_index do |expected, i|
      assert_equal expected, p.iterate(i + 1)
    end
  end

  def test_after_step10_length
    p = Polimerization.new(INPUT)
    assert_equal 3073, p.iterate(10).length
  end

  def test_diff_most_least_common_element
    p = Polimerization.new(INPUT)
    assert_equal (1749 - 161), p.diff_most_least_common_element(10)
  end
end
