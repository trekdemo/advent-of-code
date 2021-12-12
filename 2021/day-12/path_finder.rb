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
    paths = []
    current_path = [start]

    while (node = current_path.pop)
      if node == stop
        paths << current_path
        current_path = [start]
      end
    end

    paths.map { |p| p.join(',') }
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  subject = PathFinder.new(input)
  puts "Paths:\n#{subject.paths}"
  puts "Paths length: #{subject.paths.length}"
end
