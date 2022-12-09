package day01

import (
	"sort"
	"strconv"
	"strings"
)

func ToCalories(data string) (totalCalories [][]int) {
	bags := strings.Split(strings.TrimSpace(data), "\n\n")
	for _, bag := range bags {
		var elfCalories []int
		foodItems := strings.Split(bag, "\n")
		for _, food := range foodItems {
			n, err := strconv.Atoi(food)
			if err != nil {
				panic(err)
			}
			elfCalories = append(elfCalories, n)
		}
		totalCalories = append(totalCalories, elfCalories)
	}
	return totalCalories
}

func ToCaloriesAgg(data string) (agg []int) {
	for _, elfItems := range ToCalories(data) {
		total := 0
		for _, item := range elfItems {
			total += item
		}
		agg = append(agg, total)
	}
	return agg
}

func MostCalories(data string) int {
	caloriesAgg := sortedDesc(data)
	return caloriesAgg[0]
}

func Top3Calories(data string) int {
	caloriesAgg := sortedDesc(data)
	return caloriesAgg[0] + caloriesAgg[1] + caloriesAgg[2]
}

func sortedDesc(data string) []int {
	caloriesAgg := ToCaloriesAgg(data)
	sort.Slice(caloriesAgg, func(i, j int) bool {
		return caloriesAgg[j] < caloriesAgg[i]
	})
	return caloriesAgg
}
