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

  def find_by_length(arr, length)
    arr.find { |s| s.length == length }
  end

  #    aaaa    0 abcefg
  #   b    c  *1 cf
  #   b    c   2 acdeg
  #    dddd    3 acdfg
  #   e    f  *4 bcdf
  #   e    f   5 abdfg
  #    gggg    6 abdefg
  #           *7 acf
  #           *8 abcdefg
  #            9 abcdfg

  # cdfbe gcdfa fbcad cefabd cdfgeb cagedb
  #
  # ab      => 1
  # dab     => 7 -> d == a,   ab == cf
  # eafb    => 4 -> ab == cf, ea == bd
  # acedgfb => 8
  # cdfbe   => ? -> b == cf,  d == a
  #
  def deduce_mapping(map_base)
    result = {}

    # Find uniq digits
    result[find_by_length(map_base, SIGNAL_COUNT[1]).sort] = 1
    result[find_by_length(map_base, SIGNAL_COUNT[4]).sort] = 4
    result[find_by_length(map_base, SIGNAL_COUNT[7]).sort] = 7
    result[find_by_length(map_base, SIGNAL_COUNT[8]).sort] = 8

    result.merge({
                   'cagedb'.sort => 0,
                   'gcdfa'.sort => 2,
                   'fbcad'.sort => 3,
                   'cdfbe'.sort => 5,
                   'cdfgeb'.sort => 6,
                   'cefabd'.sort => 9
                 })
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
