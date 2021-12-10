# frozen_string_literal: true

# SyntaxChecker ...
class SyntaxChecker
  UNEXPECTED_SCORES = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25_137
  }.freeze

  COMPLETION_SCORES = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4
  }.freeze

  MATCHES = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
  }.freeze

  def initialize(code)
    @lines = code.split("\n")
  end

  def unexpected_score
    @lines.sum do |line|
      if (char = parse_for_unexpected(line))
        UNEXPECTED_SCORES[char]
      else
        0
      end
    end
  end

  def completion_score
    scores = @lines.map do |line|
      next unless (stack = parse_for_incomplete(line))

      stack
        .reverse
        .map { |c| MATCHES[c] }
        .reduce(0) { |a, c| a * 5 + COMPLETION_SCORES[c] }
    end.compact
    median(scores)
  end

  private

  def parse_for_unexpected(line)
    stack = []
    line.chars.each do |c|
      if MATCHES.keys.include?(c) # opening
        stack.push(c)
      elsif MATCHES.values.include?(c) # closing
        return c if MATCHES[stack.pop] != c
      end
    end

    nil
  end

  def parse_for_incomplete(line)
    stack = []
    line.chars.each do |c|
      if MATCHES.keys.include?(c) # opening
        stack.push(c)
      elsif MATCHES.values.include?(c) # closing
        return nil if MATCHES[stack.pop] != c
      end
    end

    stack
  end

  def median(array)
    return nil if array.empty?

    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  checker = SyntaxChecker.new(input)
  puts "SyntaxChecker score: #{checker.unexpected_score}"
  puts "Completion median score: #{checker.completion_score}"
end
