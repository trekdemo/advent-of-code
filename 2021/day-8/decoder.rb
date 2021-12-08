# frozen_string_literal: true

class String
  def sort
    chars.sort(&:casecmp).join
  end

  def |(other)
    (chars | other.chars).sort.join
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

  def sel_length(arr, length)
    arr.select { |s| s.length == length }
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
  def deduce_mapping(uniq_signals)
    result = Array.new(10, nil)

    # Find uniq digits
    result[1] = sel_length(uniq_signals, 2)[0].sort
    result[4] = sel_length(uniq_signals, 4)[0].sort
    result[7] = sel_length(uniq_signals, 3)[0].sort
    result[8] = sel_length(uniq_signals, 7)[0].sort

    # Find 6 long signals based on masik with known signals
    sel_length(uniq_signals, 6).each do |signal|
      if signal | result[4] != result[8]
        result[9] = signal.sort
      elsif signal | result[1] == result[8]
        result[6] = signal.sort
      else
        result[0] = signal.sort
      end
    end

    # Find 5 long signals based on masik with known signals
    sel_length(uniq_signals, 5).each do |signal|
      if signal | result[4] == result[8]
        result[2] = signal.sort
      elsif signal | result[6] == result[8]
        result[3] = signal.sort
      else
        result[5] = signal.sort
      end
    end

    Hash[result.each_with_index.map { |e, i| [e, i] }]
  end

  def sum_output_signals
    numbers = @input.map do |(uniq_signals, signals)|
      mapping = deduce_mapping(uniq_signals)
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
