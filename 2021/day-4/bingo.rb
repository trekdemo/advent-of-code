# frozen_string_literal: true

require_relative './board'

class Bingo
  attr_reader :numbers, :boards

  def initialize(input)
    numbers, *boards = input.split("\n\n")
    @numbers = numbers.split(/\s*,\s*/).map(&:to_i)
    @boards = boards.map { |b| Board.new(b) }
  end

  def simulate_first_win
    numbers.each do |n|
      boards.each_with_index do |b, i|
        return { board: i + 1, lucky_number: n, score: b.score, total_score: b.total_score } if b.mark_and_check!(n)
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('input.txt', __dir__))
  bingo = Bingo.new(input)
  puts bingo.simulate_first_win.inspect
end
