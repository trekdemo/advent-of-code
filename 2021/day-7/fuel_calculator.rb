# frozen_string_literal: true

# @param [Array] positions
def fuel1(positions)
  # target = positions.sum / positions.length
  target = positions.sort[positions.length.div(2)]
  positions.reduce(0) { |a, e| a + distance(e, target) }
end

def distance(a, b)
  if a > b
    a - b
  else
    b - a
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  positions = input.split(',').map(&:to_i)
  puts fuel1(positions)
end
