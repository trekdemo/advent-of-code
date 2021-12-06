package main

func fishPopulation(state []int, iterations int) int {
	var newAdditions int = 0

	for i := 0; i < iterations; i++ {
		for idx, e := range state {
			if e > 0 {
				state[idx] = e - 1
			} else {
				state[idx] = 6
				newAdditions++
			}
		}
		for n := 0; n < newAdditions; n++ {
			state = append(state, 8)
		}
		newAdditions = 0
	}

	return len(state)
}
