# frozen_string_literal: true

class Decoder
  SIGNAL_COUNT = {
    0 => 6,
    1 => 2,
    2 => 5,
    3 => 5,
    4 => 4,
    5 => 5,
    6 => 6,
    7 => 3,
    8 => 7,
    9 => 6
  }.freeze
  SIGNAL_COUNT_GROUP = {
    2 => [1],
    3 => [7],
    4 => [4],
    5 => [2, 3, 5],
    6 => [0, 6, 9],
    7 => [8]
  }

  def initialize(input)
    @input = input.split("\n").map do |line|
      line
        .split(/\s\|\s/)
        .map { |lr| lr.split(/\s+/) }
    end
    @output_signals = @input.map(&:last)
  end

  def count(*numbers)
    selected_signal_count = numbers.map { |n| SIGNAL_COUNT[n] }
    @output_signals.flatten.select { |s| selected_signal_count.include?(s.length) }.length
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  decoder = Decoder.new(input)
  puts decoder.count(1, 4, 7, 8)
end
