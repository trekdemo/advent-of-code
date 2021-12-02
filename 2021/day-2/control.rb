class Control
  def initialize(commands)
    @x = 0
    @z = 0
    @commands = commands.split("\n")
  end

  def execute_and_report
    execute!
    report
  end

  def execute!
    @commands.each do |line|
      dir, distance = line.split(' ')
      move(dir, distance.to_i)
    end
  end

  def report
    @x * @z
  end

  def move(direction, distance)
    case direction
    when 'forward'
      @x += distance
    when 'down'
      @z += distance
    when 'up'
      @z -= distance
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  commands = File.read('./input.txt')
  puts Control.new(commands).execute_and_report
end
