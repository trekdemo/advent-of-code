# frozen_string_literal: true

class Sonar
  def increase_count(measurements)
    measurements
      .each_cons(2)
      .select { |(a, b)| b > a }
      .count
  end

  def increase_count_from_file(file_path)
    increase_count(File.read(file_path).split("\n").map(&:to_i))
  end
end

if __FILE__ == $0
  sonar = Sonar.new
  puts sonar.increase_count_from_file('./input-small.csv')
  puts sonar.increase_count_from_file('./input-aoc.csv')
end
