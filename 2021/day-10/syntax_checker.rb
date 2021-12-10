# frozen_string_literal: true

# SyntaxChecker ...
class SyntaxChecker
  UNEXPECTED_SCORES = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25_137
  }.freeze

  MATCHES = {
    ')' => '(',
    ']' => '[',
    '}' => '{',
    '>' => '<'
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

  private

  def parse_for_unexpected(line)
    stack = []
    line.chars.each do |c|
      if MATCHES.values.include?(c) # opening
        stack.push(c)
      elsif MATCHES.keys.include?(c) # closing
        return c if MATCHES[c] != stack.pop
      end
    end

    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  checker = SyntaxChecker.new(input)
  puts "SyntaxChecker score: #{checker.unexpected_score}"
end
