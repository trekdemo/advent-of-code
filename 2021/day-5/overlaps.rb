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

  # def covered_points
  #   if y1 == y2 # horizontal
  #     Range.new(*[x1, x2].sort).to_a.map { |x| [x, y1] }
  #   elsif x1 == x2 # vertical
  #     Range.new(*[y1, y2].sort).to_a.map { |y| [x1, y] }
  #   else # diagonal
  #     []
  #   end
  # end

  def covered_points
    # https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
    res = []
    x1 = @x1
    y1 = @y1
    dx = (x2 - x1).abs
    sx = x1 < x2 ? 1 : -1
    dy = -(y2 - y1).abs
    sy = y1 < y2 ? 1 : -1
    err = dx + dy; # error value e_xy
    loop do
      res << [x1, y1]
      return res if x1 == x2 && y1 == y2

      e2 = 2 * err
      if e2 >= dy # e_xy+e_x > 0
        err += dy
        x1 += sx
      end
      if e2 <= dx # e_xy+e_y < 0
        err += dx
        y1 += sy
      end
    end
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
