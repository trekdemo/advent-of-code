# frozen_string_literal: true

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

if __FILE__ == $PROGRAM_NAME
  input = File.read(File.expand_path('./input.txt', __dir__))
  initia_state = input.split(',').map(&:to_i)
  puts fish_population(initia_state, 80)
end
