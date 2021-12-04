require 'minitest/autorun'
require_relative './bingo'

class TestBingo < Minitest::Test
  def setup
    input = File.read(File.expand_path('input-test.txt', __dir__))
    @bingo = Bingo.new(input)
  end

  def test_number_parsing
    assert_equal(
      [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24, 10, 16, 13, 6, 15, 25, 12, 22, 18, 20, 8, 19, 3, 26, 1],
      @bingo.numbers
    )
  end

  def test_board_parsing
    assert_equal 3, @bingo.boards.length
  end

  def test_simulate_first_win
    assert_equal(
      { board: 3, lucky_number: 24, score: 188, total_score: 4512 },
      @bingo.simulate_first_win
    )
  end

  def test_simulate_last_win
    assert_equal(
      { board: 2, lucky_number: 13, score: 148, total_score: 1924 },
      @bingo.simulate_last_win
    )
  end
end
