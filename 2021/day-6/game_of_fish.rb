# frozen_string_literal: true

# Initial state: 3,4,3,1,2
# After  1 day:  2,3,2,0,1
# After  2 days: 1,2,1,6,0,8
def fish_population(initial_state, iterations)
  # puts "Initial state: #{initial_state}"
  iterations.times.each_with_object(initial_state) do |_i, state|
    new_additions = []
    state.map! do |e|
      if e > 0
        e - 1
      else
        new_additions << 8
        6
      end
    end
    state.concat(new_additions)

    # puts "After #{i + 1} days: #{state}"
  end.size
end

#         0  1  2  3  4  5  6  7  8
# init:  [0, 1, 1, 2, 1, 0, 0, 0, 0]
#     1: [1, 1, 2, 1, 0, 0, 0, 0, 0]
#     2: [1, 2, 1, 0, 0, 0, 1, 0, 1]
def fish_population_better(initial_state, iterations)
  population_age_groups = Array.new(9, 0)
  puts "Pre initial state: #{population_age_groups}"
  initial_state.each do |e|
    population_age_groups[e] += 1
  end

  iterations.times do |_i|
    birthing = population_age_groups.shift
    population_age_groups.push(birthing)
    population_age_groups[6] += birthing
  end

  population_age_groups.reduce(0) { |a, e| a + e }
end

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  initia_state = input.split(',').map(&:to_i)
  puts fish_population_better(initia_state, 256)
end
