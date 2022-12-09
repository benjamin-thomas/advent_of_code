package main

import (
	"aoc/day01"
	"fmt"
	"os"
)

func main() {
	file, err := os.ReadFile("../_inputs/day01")
	if err != nil {
		panic(err)
	}
	fmt.Println("Day 01")
	fmt.Println("======")
	fmt.Printf("Answer 1: %d\n", day01.MostCalories(string(file)))
	fmt.Printf("Answer 2: %d\n", day01.Top3Calories(string(file)))
	fmt.Println("\n---\n")
}
