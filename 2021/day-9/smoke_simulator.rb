# frozen_string_literal: true

class SmokeSimulator
  def initialize(input)
    @hmap = input
  end

  def low_points
    []
  end

  def sum_risk_level
    low_points.sum { |i| i + 1 }
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  sim = SmokeSimulator.new(input)
  puts sim.sum_risk_level
end
