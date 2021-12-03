# frozen_string_literal: true

class Diagnostics
  def initialize(input)
    @report = input.split("\n")
    # Disassemble and transpose
    @transposed = @report.map { |l| l.split('') }.transpose
  end

  def gamma_rate
    @transposed
      .map { |line| most_common(line) }
      .join
      .to_i(2)
  end

  def epsilon_rate
    @transposed
      .map { |line| least_common(line) }
      .join
      .to_i(2)
  end

  def power_consumption
    gamma_rate * epsilon_rate
  end

  def oxigen_generator_rating
    list = @report.dup
    iterations = list[0].length

    iterations.times do |n|
      break if list.length == 1

      nth_bit_list = list.map { |l| l.split('') }.transpose[n]
      x = most_common(nth_bit_list)
      list.keep_if { |e| e[n] == x }
    end

    list[0].to_i(2)
  end

  def co2_scrubber_rating
    list = @report.dup
    iterations = list[0].length

    iterations.times do |n|
      break if list.length == 1

      nth_bit_list = list.map { |l| l.split('') }.transpose[n]
      x = least_common(nth_bit_list)
      list.keep_if { |e| e[n] == x }
    end

    list[0].to_i(2)
  end

  def lifesupport_rating
    oxigen_generator_rating * co2_scrubber_rating
  end

  def most_common(arr)
    freq = arr.tally

    if freq['0'] == freq['1']
      '1'
    elsif freq['0'] > freq['1']
      '0'
    else
      '1'
    end
  end

  def least_common(arr)
    freq = arr.tally
    if freq['0'] == freq['1']
      '0'
    elsif freq['0'] > freq['1']
      '1'
    else
      '0'
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input.txt')
  puts Diagnostics.new(input).power_consumption
  puts Diagnostics.new(input).lifesupport_rating
end
