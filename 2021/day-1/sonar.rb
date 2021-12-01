# frozen_string_literal: true

# Sonar - Advanced Submarine Sonar instrument
class Sonar
  def increase_count(measurements)
    measurements
      .each_cons(2)
      .select { |(a, b)| b > a }
      .count
  end

  def three_increase_count(measurements)
    increase_count(
      measurements
        .each_cons(3)
        .map(&:sum)
    )
  end
end

if __FILE__ == $PROGRAM_NAME
  sonar = Sonar.new
  measurements = File.read(ARGV[0]).split("\n").map(&:to_i)
  puts format('Simple increase: %s', sonar.increase_count(measurements))
  puts format('3 Sliding increase: %s', sonar.three_increase_count(measurements))
end
