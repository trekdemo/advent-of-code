# frozen_string_literal: true

# Polimerization ...
class Polimerization
  attr_reader :template, :rules

  def initialize(input)
    template, rules = *input.split("\n\n")
    @template = template.chars
    @rules = Hash[rules.split("\n").map { |line| line.split(/\s*->\s*/) }]
  end

  def iterate(iterations)
    poly = template

    iterations.times do |i|
      puts  i if i > 10 # This is acceptable until 20
      pairs = poly.each_cons(2).map(&:join)
      # Does not work after iterations > 15
      # rules.values_at(*pairs)
      inserts = pairs.reduce([]) { |a, e| a.push(rules[e]) }

      poly = poly.zip(inserts).flatten.compact
    end

    poly.join
  end

  def diff_most_least_common_element(iterations)
    tally = iterate(iterations).chars.tally
    min, max = *tally.values.minmax
    max - min
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  subject = Polimerization.new(input)
  puts "Diff 10: #{subject.diff_most_least_common_element(10)}"
  puts "Diff 40: #{subject.diff_most_least_common_element(40)}"
end
