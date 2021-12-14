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
    pair_counts = Hash.new(0)
    element_counts = Hash.new(0)

    template.each_cons(2) { |c| pair_counts[c] += 1 }
    template.each { |e| element_counts[e] += 1 }

    iterations.times do
      pair_counts.dup.each do |pair, count|
        left, right = *pair
        pair_counts[pair] -= count
        pair_counts[[left, rules[pair.join]]] += count
        pair_counts[[rules[pair.join], right]] += count
        element_counts[rules[pair.join]] += count
      end
    end

    element_counts
  end

  def diff_most_least_common_element(iterations)
    tally = iterate(iterations)
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
