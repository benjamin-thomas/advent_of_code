(*
   https://adventofcode.com/2022/day/1


   Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?
*)

(*
  TEST HELPERS
*)
let ( === ) =
  let open Base in
  [%test_eq: int list list]

let ( == ) =
  let open Base in
  [%test_eq: string list list]

(*
  PROGRAM STARTS HERE
*)

let partition_on delimiter lst =
  let rec inner lst acc =
    match lst with
    | [] -> [ acc ]
    | x :: xs ->
        if x = delimiter then
          acc :: inner xs []
        else
          inner xs (x :: acc)
  in
  inner (List.rev lst) [] |> List.rev

[@@@ocamlformat "disable"]

let%test_unit _ = partition_on 0 []             === [ [] ]
let%test_unit _ = partition_on 0 [ 1 ]          === [ [ 1 ] ]
let%test_unit _ = partition_on 0 [ 1; 2 ]       === [ [ 1; 2 ] ]
let%test_unit _ = partition_on 0 [ 1; 2; 0; 3 ] === [ [ 1; 2 ]; [ 3 ] ]

let%test_unit _ = partition_on 0 [ 1; 2; 0; 3; 4; 0; 8; 99; 0; 2 ] === [ [ 1; 2 ]; [ 3; 4 ]; [ 8; 99 ]; [ 2 ] ]

[@@@ocamlformat "enable"]

let greet = "Hello day 1!"

let%test_unit _ =
  let open Base in
  [%test_result: string] greet ~expect:"Hello day 1!"

let%test_unit "List.length" =
  [%test_result: Base.int] (List.length [ 1; 2 ]) ~expect:2

let get_input () =
  let open In_channel in
  with_open_text "inputs/day01" input_all

let input_fake = {|1
2
3

4
5
6

20|}

let%test_unit _ =
  partition_on "" [ "a"; "b"; ""; "c" ] == [ [ "a"; "b" ]; [ "c" ] ]

let to_ints = List.map (List.map (fun str -> int_of_string str))

let to_elves input =
  partition_on "" (String.split_on_char '\n' input) |> to_ints

let%test_unit _ =
  [%test_result: Base.int Base.list Base.list] (to_elves input_fake)
    ~expect:[ [ 1; 2; 3 ]; [ 4; 5; 6 ]; [ 20 ] ]

let greatest_sum (elves : int list list) =
  let rec sum lst =
    match lst with
    | [] -> 0
    | x :: xs -> x + sum xs
  in
  List.map sum elves |> List.sort (fun a b -> b - a) |> List.hd

let%test_unit _ =
  [%test_result: Base.int]
    (greatest_sum [ [ 1; 2; 3 ]; [ 4; 5; 6 ]; [ 20 ] ])
    ~expect:20

let most_calories input = to_elves input |> greatest_sum
