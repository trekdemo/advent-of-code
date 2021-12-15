# frozen_string_literal: true

require 'minitest/autorun'
require_relative './maze'

# MazeTest ...
class MazeTest < Minitest::Test
  def maze
    Maze.new(<<~INPUT)
      1163751742
      1381373672
      2136511328
      3694931569
      7463417111
      1319128137
      1359912421
      3125421639
      1293138521
      2311944581
    INPUT
  end

  def test_best_path_score
    score, _path = *maze.astar
    assert_equal(
      [1, 1, 2, 1, 3, 6, 5, 1, 1, 1, 5, 1, 1, 3, 2, 3, 2, 1, 1].sum - 1,
      score
    )
  end

  def test_best_path
    _score, path = *maze.astar
    assert_equal [1, 1, 2, 1, 3, 6, 5, 1, 1, 1, 5, 1, 1, 3, 2, 3, 2, 1, 1], path
  end
end
