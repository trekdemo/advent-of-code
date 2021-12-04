require 'minitest/autorun'
require_relative './board'

class TestBoard < Minitest::Test
  def setup
    @board = Board.new(<<~BOARD)
      22 13 17 11  0
       8  2 23  4 24
      21  9 14 16  7
       6 10  3 18  5
       1 12 20 15 19
    BOARD

    @winning_board = Board.new(<<~BOARD)
      14 21 17 24  4
      10 16 15  9 19
      18  8 23 26 20
      22 11 13  6  5
      2  0 12  3  7
    BOARD

    # Mark numbers
    [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24].each do |n|
      @winning_board.mark_and_check!(n)
    end
  end

  def test_constructor
    assert_equal(
      [22, 13, 17, 11, 0, 8, 2, 23, 4, 24, 21, 9, 14, 16, 7, 6, 10, 3, 18, 5, 1, 12, 20, 15, 19],
      @board.board
    )
  end

  def test_score
    assert @winning_board.won?
    assert_equal 24, @winning_board.winning_number
    assert_equal 188, @winning_board.score
    assert_equal 4512, @winning_board.total_score
  end

  def test_rows_and_columns
    assert_equal(
      [
        # Rows
        [22, 13, 17, 11, 0],
        [8,  2, 23,  4, 24],
        [21, 9, 14, 16, 7],
        [6, 10, 3, 18, 5],
        [1, 12, 20, 15, 19],

        # Columns
        [22, 8, 21, 6, 1],
        [13, 2, 9, 10, 12],
        [17, 23, 14, 3, 20],
        [11, 4, 16, 18, 15],
        [0, 24, 7, 5, 19]
      ],
      @board.rows_and_columns.to_a
    )
  end
end
