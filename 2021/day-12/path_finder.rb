# frozen_string_literal: true

require 'set'

class PathFinder
  attr_accessor :start, :stop, :graph

  def initialize(input, start = 'start', stop = 'end')
    @graph = Hash.new { |h, k| h[k] = Set.new }
    @start = start
    @stop = stop

    input.strip.split("\n").each do |line|
      left, right = *line.split('-')
      @graph[left] << right
      @graph[right] << left
    end
  end

  def paths
    all_paths = []
    visited = []
    current_path = [start]

    paths_between(start, stop, visited, current_path, all_paths)

    all_paths
  end

  # @param [Array] visited
  # @param [Array<String>] local_path
  # @param [Array<Array>] all_paths
  def paths_between(start, dest, visited, local_path, all_paths)
    if start == dest
      all_paths.push(local_path.join(','))
      return
    end

    visited.push(start) unless start == start.upcase
    graph[start].sort.each do |node|
      next if visited.include?(node)

      paths_between(node, dest, visited, local_path.dup.push(node), all_paths)
    end

    visited.delete(start)
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  subject = PathFinder.new(input)
  puts "Paths:\n#{subject.paths}"
  puts "Paths length: #{subject.paths.length}"
end
