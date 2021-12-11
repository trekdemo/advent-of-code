# frozen_string_literal: true

require 'minitest/autorun'
require_relative './dombo_octopus'

Minitest::Assertions.diff = nil

def grid(input)
  DumboGrid.new(input)
end

# DumboOctopusTest...
class DumboOctopusBiggerTest < Minitest::Test
  def dumbo
    DumboOctopus.new(<<~INPUT)
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
    INPUT
  end

  def test_sim_n1
    assert_equal grid(<<~EXP), dumbo.simulate(1)
      6594254334
      3856965822
      6375667284
      7252447257
      7468496589
      5278635756
      3287952832
      7993992245
      5957959665
      6394862637
    EXP
  end

  def test_sim_n2
    assert_equal grid(<<~EXP), dumbo.simulate(2)
      8807476555
      5089087054
      8597889608
      8485769600
      8700908800
      6600088989
      6800005943
      0000007456
      9000000876
      8700006848
    EXP
  end

  def test_sum_flashes_n10
    assert_equal 1656, dumbo.sum_flashes(_n = 100)
  end

  def test_first_sync
    assert_equal 195, dumbo.first_sync
  end
end

# DumboOctopusTest...
class DumboOctopusSimpleTest < Minitest::Test
  def make_dumbo
    DumboOctopus.new(<<~INPUT)
      11111
      19991
      19191
      19991
      11111
    INPUT
  end

  def test_sim_n0
    assert_equal grid(<<~EXP), make_dumbo.simulate(_n = 0)
      11111
      19991
      19191
      19991
      11111
    EXP
  end

  def test_sim_n1
    assert_equal grid(<<~EXP), make_dumbo.simulate(_n = 1)
      34543
      40004
      50005
      40004
      34543
    EXP
  end

  def test_sim_n2
    assert_equal grid(<<~EXP), make_dumbo.simulate(_n = 2)
      45654
      51115
      61116
      51115
      45654
    EXP
  end
end
