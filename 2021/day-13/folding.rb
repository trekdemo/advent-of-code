# frozen_string_literal: true

require 'drawille'

class Folder
  attr_accessor :dots, :instructions

  def initialize(input)
    dots, instructions = *input.split("\n\n").map { |bl| bl.split("\n") }

    @dots = dots.map { |d| d.split(',').map(&:to_i) }
    @instructions = instructions.map do |e|
      if (match = e.match(/fold along (?<axis>x|y)=(?<value>\d+)/))
        match[:axis] == 'x' ? [match[:value].to_i, 0] : [0, match[:value].to_i]
      end
    end
  end

  def fold(instruction_count = @instructions.length)
    instructions.take(instruction_count).reduce(@dots) do |dots, i|
      dots.map do |d|
        [
          i[0].positive? ? inv_abs(d[0] - i[0]) + i[0] : d[0],
          i[1].positive? ? inv_abs(d[1] - i[1]) + i[1] : d[1]
        ]
      end.uniq
    end
  end

  def draw_fold(instruction_count = @instructions.length)
    canvas = Drawille::Canvas.new
    fold(instruction_count).each do |(x, y)|
      canvas.set(x, y)
    end
    puts canvas.frame
  end

  private

  def inv_abs(num)
    num.positive? ? num * -1 : num
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  subject = Folder.new(input)
  puts "Dots after one fold: #{subject.fold(1).length}"
  subject.draw_fold
end
