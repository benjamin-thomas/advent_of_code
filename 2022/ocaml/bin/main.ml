(* dune exec ./bin/main.exe *)
let () =
  let open Aoc_lib in
  let input = Utils.read_input "../inputs/day01" in
  let part1_answer = input |> Day01.most_calories in
  let part2_answer = input |> Day01.top3_calories in
  Printf.printf "\n\nPart 1 answer is: %d\n" part1_answer;
  Printf.printf "Part 2 answer is: %d\n" part2_answer
