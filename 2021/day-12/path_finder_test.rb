# frozen_string_literal: true

require 'minitest/autorun'
require_relative './path_finder'

class PathFinderTest < Minitest::Test
  def assert_matched_arrays(expected, actual)
    assert_empty expected - actual
    assert_equal expected.to_ary.sort, actual.to_ary.sort
  end

  def test_paths_n1
    path_finder = PathFinder.new(<<~SEGMENTS)
      start-A
      start-b
      A-c
      A-b
      b-d
      A-end
      b-end
    SEGMENTS
    assert_matched_arrays [
      'start,A,b,A,b,A,c,A,end',
      'start,A,b,A,b,A,end',
      'start,A,b,A,b,end',
      'start,A,b,A,c,A,b,A,end',
      'start,A,b,A,c,A,b,end',
      'start,A,b,A,c,A,c,A,end',
      'start,A,b,A,c,A,end',
      'start,A,b,A,end',
      'start,A,b,d,b,A,c,A,end',
      'start,A,b,d,b,A,end',
      'start,A,b,d,b,end',
      'start,A,b,end',
      'start,A,c,A,b,A,b,A,end',
      'start,A,c,A,b,A,b,end',
      'start,A,c,A,b,A,c,A,end',
      'start,A,c,A,b,A,end',
      'start,A,c,A,b,d,b,A,end',
      'start,A,c,A,b,d,b,end',
      'start,A,c,A,b,end',
      'start,A,c,A,c,A,b,A,end',
      'start,A,c,A,c,A,b,end',
      'start,A,c,A,c,A,end',
      'start,A,c,A,end',
      'start,A,end',
      'start,b,A,b,A,c,A,end',
      'start,b,A,b,A,end',
      'start,b,A,b,end',
      'start,b,A,c,A,b,A,end',
      'start,b,A,c,A,b,end',
      'start,b,A,c,A,c,A,end',
      'start,b,A,c,A,end',
      'start,b,A,end',
      'start,b,d,b,A,c,A,end',
      'start,b,d,b,A,end',
      'start,b,d,b,end',
      'start,b,end'
    ], path_finder.paths
  end
end
