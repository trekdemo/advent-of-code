# frozen_string_literal: true

require 'minitest/autorun'
require_relative './folding'
# class Point
#   attr_accessor :x, :y

#   def initialize(x, y)
#     @x = x
#     @y = y
#   end

#   def transform(x, y)
#     @x += x
#     @y += y
#   end
# end

class FoldingTest < Minitest::Test
  def folder
    Folder.new(<<~INPUT)
      0,13
      0,14
      0,3
      1,10
      10,12
      10,4
      2,14
      3,0
      3,4
      4,1
      4,11
      6,0
      6,10
      6,12
      8,10
      8,4
      9,0
      9,10

      fold along y=7
      fold along x=5
    INPUT
  end

  def test_fold_1_count
    assert_equal 17, folder.fold(1).length
  end

  def test_draw_fold
    assert_output(<<~EXP) { folder.draw_fold(0) }
      ⡀⠈⠂⠁⠈⠀
      ⠀⠈⠀⠀⠁⠁
      ⠠⠀⡀⠄⠤⠀
      ⠆⠄⠀⠁⠀⠁
    EXP
    assert_output(<<~EXP) { folder.draw_fold(1) }
      ⡃⠉⡂⠅⠈⠄
      ⠈⠈⠀⠁⠉⠁
    EXP
    assert_output(<<~EXP) { folder.draw_fold }
      ⡏⠉⡇
      ⠉⠉⠁
    EXP
  end
end
