package main

import "testing"

func TestIterationAfter18Days(t *testing.T) {
	var initialState = []int{3, 4, 3, 1, 2}
	var got int = fishPopulation(initialState, 18)
	if got != 26 {
		t.Fatalf("Expected 26; got %d", got)
	}
}

func TestIterationAfter80Days(t *testing.T) {
	var initialState = []int{3, 4, 3, 1, 2}
	var got int = fishPopulation(initialState, 80)
	if got != 5934 {
		t.Fatalf("Expected 5934; got %d", got)
	}
}

func TestIterationAfter256Days(t *testing.T) {
	var initialState = []int{3, 4, 3, 1, 2}
	var got int = fishPopulation(initialState, 256)
	if got != 26984457539 {
		t.Fatalf("Expected 26984457539; got %d", got)
	}
}
