# frozen_string_literal: true

class Grid
  def initialize(input)
    @grid = input
  end

  def each_with_index
    Enumerator.new do |yielder|
      @grid.each_with_index do |row, y|
        row.each_with_index do |e, x|
          yielder << [e, [x, y]]
        end
      end
    end
  end

  def get(x, y)
    return nil if x < 0 || y < 0

    @grid[y] && @grid[y][x]
  end

  # x1x
  # 4 2
  # x3x
  def adjacents(x, y)
    [
      get(x, y - 1),
      get(x + 1, y),
      get(x, y + 1),
      get(x - 1, y)
    ].compact
  end
end

class SmokeSimulator
  def initialize(input)
    @hmap = Grid.new(input.split(/\n/).map { |l| l.chars.map(&:to_i) })
  end

  def low_points
    @low_points ||= @hmap.each_with_index.select do |e, (x, y)|
      adjacents = @hmap.adjacents(x, y)
      # puts format('(%d, %d): %d -> %s', x, y, e, adjacents)
      adjacents.all? { |a| a > e }
    end
  end

  def sum_risk_level
    low_points.map(&:first).sum { |i| i + 1 }
  end
end

if __FILE__ == $PROGRAM_NAME
  %w[input-small.txt input.txt].each do |fname|
    input = File.read(File.expand_path("./#{fname}", __dir__))
    sim = SmokeSimulator.new(input)

    puts "Risk level: #{sim.sum_risk_level}"
    puts "Low points #{sim.low_points.length}"
    puts sim.low_points.map(&:first).inspect
    puts
  end
end
