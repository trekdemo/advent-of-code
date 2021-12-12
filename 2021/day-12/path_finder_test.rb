# frozen_string_literal: true

require 'minitest/autorun'
require_relative './path_finder'

class PathFinderTest < Minitest::Test
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
    assert_equal [
      'start,A,b,A,c,A,end',
      'start,A,b,A,end',
      'start,A,b,end',
      'start,A,c,A,b,A,end',
      'start,A,c,A,b,end',
      'start,A,c,A,end',
      'start,A,end',
      'start,b,A,c,A,end',
      'start,b,A,end',
      'start,b,end'
    ], path_finder.paths
  end

  def test_paths_n2
    path_finder = PathFinder.new(<<~SEGMENTS)
      dc-end
      HN-start
      start-kj
      dc-start
      dc-HN
      LN-dc
      HN-end
      kj-sa
      kj-HN
      kj-dc
    SEGMENTS
    assert_equal [
      'start,HN,dc,HN,end',
      'start,HN,dc,HN,kj,HN,end',
      'start,HN,dc,end',
      'start,HN,dc,kj,HN,end',
      'start,HN,end',
      'start,HN,kj,HN,dc,HN,end',
      'start,HN,kj,HN,dc,end',
      'start,HN,kj,HN,end',
      'start,HN,kj,dc,HN,end',
      'start,HN,kj,dc,end',
      'start,dc,HN,end',
      'start,dc,HN,kj,HN,end',
      'start,dc,end',
      'start,dc,kj,HN,end',
      'start,kj,HN,dc,HN,end',
      'start,kj,HN,dc,end',
      'start,kj,HN,end',
      'start,kj,dc,HN,end',
      'start,kj,dc,end'
    ], path_finder.paths
  end
end
