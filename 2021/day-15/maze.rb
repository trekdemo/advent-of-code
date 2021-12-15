# frozen_string_literal: true

# Grid ...
class Grid
  def initialize(input)
    @height = input.length
    @width = input[0].length
    @grid = input.each_with_index.map do |row, y|
      row.each_with_index.map do |e, x|
        Node.new(self, x, y, risk: e.to_i)
      end
    end
  end

  def start
    get(0, 0)
  end

  def stop
    get(@width - 1, @height - 1)
  end

  def get(x, y)
    return nil if x < 0 || y < 0
    return nil if x >= @width || y >= @height

    @grid[y][x]
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

class Node
  attr_accessor :grid, :risk, :g, :h, :prev
  attr_reader :r, :c, :near

  def initialize(grid, r, c, risk: 0)
    @grid = grid
    @r = r
    @c = c
    @risk = risk

    @g = 0.0
    @h = 0.0

    @prev = nil
    @near = near
  end

  def ==(other)
    r == other.r && c == other.c
  end

  def f
    g + risk
  end

  def distance(node)
    (
      (@r - node.r)**2 +
      (@c - node.c)**2
    )**0.5
  end

  def adjacents
    @grid.adjacents(r, c)
  end

  def to_s
    format('(%d,%d risk=%d)', r, c, risk)
  end
  alias inspect to_s
end

# Maze ...
class Maze
  def initialize(maze = '')
    @maze = Grid.new(maze.split("\n").map { |l| l.split('') })
    @start = @maze.start
    @stop = @maze.stop
    # There will be two sets at the center of the algorithm.
    # The first is the openset, that is the set that contains
    # all the nodes that we have not explored yet.
    # It is initialized with only the starting node.
    @openset = [@start]
    # The closed set is the second set that contains all
    # the nodes thar already been explored and are in our
    # path or are failing strategy
    @closedset = []

    # Let's initialize the starting point
    # Obviously it has distance from start that is zero
    @start.g = 0
    # and we evaluate the distance from the ending point
    @start.h = @start.distance(@stop)
  end

  def astar
    # The search continues until there are nodes in the openset
    # If there are no nodes, the path will be an empty list.
    until @openset.empty?
      # The next node is the one that has the minimum distance
      # from the origin and the minimum distance from the exit.
      # Thus it should have the minimum value of f.
      x = @openset.min_by(&:f)

      # If the next node selected is the stop node we are arrived.
      if x == @stop
        # And we can return the path by reconstructing it
        # recursively backward.
        return reconstruct_path(x)
      end

      # We are now inspecting the node x. We have to remove it
      # from the openset, and to add it to the closedset.
      @openset.delete(x)
      @closedset.push(x)

      # Let's test all the nodes that are near to the current one
      x.adjacents.each do |y|
        next if @closedset.include?(y)

        g_score = x.risk + y.risk

        # There are three condition to be taken into account
        #  1. y is not in the openset. This is always an improvement
        #  2. y is in the openset, but the new g_score is lower
        #     so we have found a better strategy to reach y
        #  3. y has already a better g_score, or inany case
        #     this strategy is not an improvement

        # First case: the y point is a new node for the openset
        # thus it is an improvement
        if !@openset.include?(y)
          @openset.push(y)
          improving = true
        # Second case: the y point was already into the openset
        # but with a value of g that is lower with respect to the
        # one we have just found. That means that our current strategy
        # is reaching the point y faster. This means that we are
        # improving.
        elsif g_score < y.g
          improving = true
        # Third case: The y point is not in the openset, and the
        # g_score is not lower with respect to the one already saved
        # into the node y. Thus, we are not improving and this
        # current strategy is not good.
        else
          improving = false
        end

        # We had an improvement
        next unless improving

        # so we reach y from x
        y.prev = x
        # we update the gscore value
        y.g = g_score
        # and we update also the value of the heuristic
        # distance from the stop
        # y.h = y.distance(@stop)
      end

      # The loop instruction is over, thus we are ready to
      # select a new node.
    end

    # If we never encountered a return before means that we
    # have finished the node in the openset and we never
    # reached the @stop point.
    # We are returning an empty path.
    [0, []]
  end

  def reconstruct_path(curr)
    path = [curr]
    while curr.prev
      path.prepend(curr.prev)
      curr = curr.prev
    end

    [path.sum(&:risk), path.map(&:risk)]
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  subject = Maze.new(input)
  puts "Best Paths score: #{subject.astar.first}"
end
