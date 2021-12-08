# frozen_string_literal: true

class String
  def sort
    chars.sort(&:casecmp).join
  end
end

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

  def deduce_mapping(_map_base)
    {
      'cagedb'.sort => 0,
      'ab'.sort => 1,
      'gcdfa'.sort => 2,
      'fbcad'.sort => 3,
      'eafb'.sort => 4,
      'cdfbe'.sort => 5,
      'cdfgeb'.sort => 6,
      'dab'.sort => 7,
      'acedgfb'.sort => 8,
      'cefabd'.sort => 9
    }
  end

  def sum_output_signals
    numbers = @input.map do |(map_base, signals)|
      mapping = deduce_mapping(map_base)
      signals.map do |signal|
        mapping[signal.sort]
      end.join.to_i
    end

    numbers.sum
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  decoder = Decoder.new(input)
  puts decoder.count(1, 4, 7, 8)
  puts decoder.sum_output_signals
end
