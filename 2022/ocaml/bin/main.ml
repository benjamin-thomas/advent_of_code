(* dune exec ./bin/main.exe *)
let () =
  let open Aoc_lib in
  let input = Utils.read_input "../_inputs/day01" |> Day01.from_input in
  let answer1 = input |> Day01.most_calories in
  let answer2 = input |> Day01.top3_calories in
  Printf.printf "\n\nPart 1 answer is: %d\n" answer1;
  Printf.printf "Part 2 answer is: %d\n" answer2;

  (* day 2*)
  let input = Utils.read_input "../_inputs/day02" |> Day02.from_input in
  let answer1 = Day02.rounds input |> Day01.sum in
  Printf.printf "\n\nDay2 part 1 answer is: %d\n" answer1;
  let answer2 = Day02.rounds_v2 input |> Day01.sum in
  Printf.printf "nDay2 part 2 answer is: %d\n" answer2
