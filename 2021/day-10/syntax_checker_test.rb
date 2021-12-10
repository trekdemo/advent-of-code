# frozen_string_literal: true

require 'minitest/autorun'
require_relative './syntax_checker'

# SyntaxCheckerTest ...
class SyntaxCheckerTest < Minitest::Test
  def setup
    @checker = SyntaxChecker.new(<<~CODE)
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]
    CODE
  end

  def test_score
    # In the above example, an illegal ) was found twice (2*3 = 6 points), an
    # illegal ] was found once (57 points), an illegal } was found once (1197
    # points), and an illegal > was found once (25137 points). So, the total
    # syntax error score for this file is 6+57+1197+25137 = 26397 points!
    assert_equal ((2 * 3) + 57 + 1197 + 25_137), @checker.unexpected_score
  end

  def test_completion_score
    assert_equal 288_957, @checker.completion_score
  end
end
