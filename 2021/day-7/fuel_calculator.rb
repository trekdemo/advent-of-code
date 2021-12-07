# frozen_string_literal: true

# @param [Array] positions
def fuel1(positions)
  # target = positions.sum / positions.length
  target = positions.sort[positions.length.div(2)]
  positions.reduce(0) { |a, e| a + distance(e, target) }
end

# @param [Array] positions
def fuel2(positions)
  target = (positions.sum.to_f / positions.length).round
  positions.reduce(0) { |a, e| a + fuel_cost(e, target) }
end

# @param [Array] positions
def fuel_brute(positions)
  min, max = *positions.minmax
  (min..max).map do |target|
    positions.reduce(0) { |a, e| a + fuel_cost(e, target) }
  end.min
end

def distance(a, b)
  a > b ? a - b : b - a
end

def fuel_cost(a, b)
  # distance(a, b).times.reduce(0) { |acc, e| acc + e + 1 }
  # Gauss formula
  n = distance(a, b)
  (n / 2.0) * (1 + n)
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  positions = input.split(',').map(&:to_i)
  puts fuel1(positions)
  puts fuel2(positions)
  puts fuel_brute(positions)
end
