# frozen_string_literal: true

require 'set'

# Board represents a Bingo board
#   22 13 17 11  0
#    8  2 23  4 24
#   21  9 14 16  7
#    6 10  3 18  5
#    1 12 20 15 19
class Board
  attr_reader :board, :found, :index

  # @param [String] board is a space separated matrix of numbers
  def initialize(board, index = 1)
    @board = board.split(/\s+/).map(&:to_i)
    @found = []
    @index = index
  end

  def won?
    rows_and_columns.any? { |l| (l & found).length == 5 }
  end

  def mark_and_check!(number)
    @found << number if board.include?(number)

    won?
  end

  def winning_number
    found.last if won?
  end

  def score
    board
      .reject { |n| found.include?(n) }
      .reduce(0) { |a, e| a + e }
  end

  def total_score
    score * found.last
  end

  def rows_and_columns
    Enumerator.new do |yielder|
      board.each_slice(5) do |row|
        yielder << row
      end
      5.times do |i|
        yielder << board.values_at(*[0, 5, 10, 15, 20].map { |e| (e + i) })
      end
    end
  end
end
