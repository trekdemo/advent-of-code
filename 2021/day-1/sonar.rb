# frozen_string_literal: true

# Sonar - Advanced Submarine Sonar instrument
class Sonar
  attr_reader :measurements

  def initialize(measurements)
    @measurements = measurements
  end

  def increase_count
    _increase_count(measurements)
  end

  def three_increase_count
    noise_reduced_measurements = measurements.each_cons(3).map(&:sum)
    _increase_count(noise_reduced_measurements)
  end

  private

  def _increase_count(measurements)
    measurements
      .each_cons(2)
      .select { |(a, b)| b > a }
      .count
  end
end

if __FILE__ == $PROGRAM_NAME
  measurements = File.read(ARGV[0]).split("\n").map(&:to_i)
  sonar = Sonar.new(measurements)
  puts format('Simple increase: %s', sonar.increase_count)
  puts format('3 Sliding increase: %s', sonar.three_increase_count)
end
