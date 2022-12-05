use std::fs;

use aoc::{from_input, most_calories, top3_calories};

fn read(day: &str) -> String {
    return fs::read_to_string(format!("../inputs/{}", day))
        .expect(&format!("Could not open {} data", day));
}

/*
   cargo run
*/
pub fn main() {
    let input = read("day01");
    let calories = from_input(&input);

    let answer1 = most_calories(calories.clone());
    println!("Answer 1: {}", answer1);

    let answer2 = top3_calories(calories);
    println!("Answer 2: {}", answer2);
}
