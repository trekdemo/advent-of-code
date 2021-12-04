# frozen_string_literal: true

require_relative './board'

class Bingo
  attr_reader :numbers, :boards

  def initialize(input)
    numbers, *boards = input.split("\n\n")
    @numbers = numbers.split(/\s*,\s*/).map(&:to_i)
    @boards = boards.each_with_index.map { |b, i| Board.new(b, i + 1) }
  end

  def simulate_first_win
    numbers.each do |n|
      boards.each do |b|
        if b.mark_and_check!(n)
          return { board: b.index, lucky_number: n, score: b.score,
                   total_score: b.total_score }
        end
      end
    end
  end

  def simulate_last_win
    winning_boards = []

    numbers.each do |n|
      boards.each do |b|
        next if b.won?

        winning_boards << b if b.mark_and_check!(n)
      end
    end

    b = winning_boards.last
    { board: b.index, lucky_number: b.winning_number, score: b.score,
      total_score: b.total_score }
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('input.txt', __dir__))
  bingo = Bingo.new(input)
  puts bingo.simulate_first_win.inspect
  puts bingo.simulate_last_win.inspect
end
