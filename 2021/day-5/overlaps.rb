# frozen_string_literal: true

class Overlaps
  LINE_FORMAT = /^(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)$/

  def initialize(input)
    @input = input
  end

  def overlaps
    @input
      .split("\n") # Split up into strings of line segments
      .map { |l| LineSegment.new(*l.match(LINE_FORMAT).captures.map(&:to_i)) }
      .map(&:covered_points)
      .flatten(1)
      .tally
      .reduce(0) { |a, e| e.last > 1 ? a + 1 : a }
  end
end

class LineSegment
  attr_accessor :x1, :y1, :x2, :y2

  def initialize(x1, y1, x2, y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def diagonal?
    x1 != x2 && y1 != y2
  end

  def covered_points
    if y1 == y2 # horizontal
      Range.new(*[x1, x2].sort).to_a.map { |x| [x, y1] }
    elsif x1 == x2 # vertical
      Range.new(*[y1, y2].sort).to_a.map { |y| [x1, y] }
    else # diagonal
      []
    end
  end

  def covered_points
    res = []
    if x1 == x2
      res = Range.new(*[y1, y2].sort).map { |y| [x1, y] }
    elsif y1 == y2
      res = Range.new(*[x1, x2].sort).map { |x| [x, y1] }
    else
      # https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
      dx = x2 - x1
      dy = y2 - y1
      d = 2 * dy - dx
      y = y1
      dir = x1 > x2 ? :downto : :upto
      x1.send(dir, x2) do |x|
        res << [x, y]
        if d > 0
          y += 1
          d -= 2 * dx
        end
        d += 2 * dy
      end
    end

    puts "#{inspect}: #{res}"
    res
  end

  def inspect
    "#{x1},#{y1} -> #{x2},#{y2}"
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('input.txt', __dir__))
  overlaps = Overlaps.new(input)
  puts overlaps.overlaps
end
