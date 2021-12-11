# frozen_string_literal: true

require 'set'

class Grid
  attr_accessor :grid

  def initialize(input)
    @grid = input
    @height = input.length
    @width = input[0].length
  end

  # @yield [elem, pos] Steps through all elements
  #
  # @yieldparam [Array<Int>] pos the grid position of the element
  def each_with_index
    return enum_for(:each_with_index) unless block_given?

    @grid.each_with_index do |row, y|
      row.each_with_index do |e, x|
        yield [e, [x, y]]
      end
    end
  end

  def set(x, y, value)
    return nil if x < 0 || y < 0
    return nil if x >= @width || y >= @height

    @grid[y][x] = value
  end

  def get(x, y)
    return nil if x < 0 || y < 0
    return nil if x >= @width || y >= @height

    [@grid[y][x], [x, y]]
  end

  # Returns adjacent elements with position, diagonal included
  def adjacents(x, y)
    [
      [x - 1, y - 1],
      [x + 0, y - 1],
      [x + 1, y - 1],

      [x - 1, y + 0],
      [x + 0, y + 0],
      [x + 1, y + 0],

      [x - 1, y + 1],
      [x + 0, y + 1],
      [x + 1, y + 1]
    ].compact
  end

  def to_s
    @grid.map { |r| r.map { |e| e.to_s(16).upcase }.join }.join("\n")
  end

  def ==(other)
    if other.is_a?(String)
      to_s == other.strip
    elsif other.is_a?(Grid)
      grid == other.grid
    else
      false
    end
  end

  def dup
    self.class.new(@grid.dup)
  end
end

class DumboGrid < Grid
  def initialize(input)
    super(input.strip.split("\n").map { |e| e.split('').map(&:to_i) })
  end
end

# DumboOctopus...
class DumboOctopus
  attr_accessor :grid

  def initialize(input)
    @grid = DumboGrid.new(input)
  end

  def sum_flashes(iterations = 0)
    res = 0

    simulate(iterations) do |grid, _i|
      res += grid.each_with_index.sum { |e, _| e == 0 ? 1 : 0 }
    end

    res
  end

  def simulate(iterations, debug = false, max_charge = 9)
    puts '=' * 80 if debug
    puts grid.to_s if debug

    iterations.times do |i|
      puts '-' * 80 if debug
      puts "Iteration #{i}: " if debug

      ready_to_flash = []
      flashed = Set.new

      # Charge each octo
      grid.each_with_index do |e, (x, y)|
        new_charge = e + 1
        grid.set(x, y, new_charge)
        ready_to_flash << [x, y] if new_charge > max_charge
      end

      while (flsh = ready_to_flash.pop)
        flashed << flsh
        (grid.adjacents(*flsh) - flashed.to_a - ready_to_flash).each do |(x, y)|
          c = grid.get(x, y)
          next unless c

          new_charge = c.first + 1
          grid.set(x, y, new_charge)

          ready_to_flash << [x, y] if new_charge > max_charge
        end
      end

      # Every flashed octo is set to 0
      flashed.each do |(x, y)|
        grid.set(x, y, 0)
      end
      puts '-' * 80 if debug
      puts grid.to_s if debug

      yield [grid, i] if block_given?
    end

    grid
  end

  def first_sync
    simulate(999) do |grid, i|
      return i + 1 if grid.grid.flatten.all?(&:zero?)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  subject = DumboOctopus.new(input)
  puts "Sum of flashes: #{subject.sum_flashes(100)}"
  puts "First sync: #{subject.first_sync}"
end
