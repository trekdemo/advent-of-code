# frozen_string_literal: true

class Grid
  def initialize(input)
    @grid = input
    @height = input.length
    @width = input[0].length
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
    return nil if x >= @width || y >= @height

    [@grid[y][x], [x, y]]
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
      adjacents.all? { |a| a.first > e }
    end
  end

  def basins
    low_points.map do |p|
      extend_neighbors_until(p)
    end
  end

  def extend_neighbors_until(point, max_height = 9)
    res = [point]
    to_check = @hmap.adjacents(*point.last).select { |p| p.first < max_height }
    while (c = to_check.pop)
      next if c.first >= max_height

      res << c
      to_check.concat(
        @hmap.adjacents(*c.last).select { |p| p.first < max_height } - res - to_check
      )
    end
    res
  end

  def sum_risk_level
    low_points.map(&:first).sum { |i| i + 1 }
  end

  def basin_product(take = 3)
    basins.sort_by(&:length).last(take).reduce(1) { |a, e| a * e.length }
  end
end

if __FILE__ == $PROGRAM_NAME
  %w[input-small.txt input.txt].each do |fname|
    input = File.read(File.expand_path("./#{fname}", __dir__))
    sim = SmokeSimulator.new(input)

    puts "Risk level: #{sim.sum_risk_level}"
    puts "Low points #{sim.low_points.length}"
    puts "Basin product: #{sim.basin_product}"
    puts
  end
end
