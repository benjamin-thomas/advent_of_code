package day01_test

/*
rg --files | entr -cr go test aoc/day01
*/

import (
	"aoc/day01"
	"reflect"
	"testing"
)

var INPUT = `
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
`

func TestToCalories(t *testing.T) {
	got := day01.ToCalories(INPUT)
	expected := [][]int{{1000, 2000, 3000}, {4000}, {5000, 6000}, {7000, 8000, 9000}, {10000}}
	if !reflect.DeepEqual(got, expected) {
		t.Errorf("Got: %v; want: %v", got, expected)
	}
}

func TestToCaloriesAgg(t *testing.T) {
	got := day01.ToCaloriesAgg(INPUT)
	expected := []int{6000, 4000, 11000, 24000, 10000}
	if !reflect.DeepEqual(got, expected) {
		t.Errorf("Got: %v; want: %v", got, expected)
	}
}

func TestMostCalories(t *testing.T) {
	want := 24000
	got := day01.MostCalories(INPUT)
	if got != want {
		t.Errorf("Want: %d, got: %d", want, got)
	}
}

func TestTop3Calories(t *testing.T) {
	want := 45000
	got := day01.Top3Calories(INPUT)
	if got != want {
		t.Errorf("Want: %d, got: %d", want, got)
	}
}
