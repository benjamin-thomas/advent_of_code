let get_input () =
  let open In_channel in
  with_open_text "inputs/day01" input_all

(* dune exec ./bin/main.exe *)
let () =
  let input = get_input () in
  let answer = Lib.Day01.most_calories input in
  Printf.printf "\n\nAnswer is: %d\n" answer
