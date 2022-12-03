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

let from_input_hard input =
  String.split_on_char '\n' input
  |> partition_on ""
  |> List.map (List.map (fun str -> int_of_string str))

let%test_unit _ =
  [%test_result: Base.int Base.list Base.list]
    (from_input_hard input_fake)
    ~expect:[ [ 1; 2; 3 ]; [ 4; 5; 6 ]; [ 20 ] ]

let from_input_easy input : int list list =
  input
  |> Str.split @@ Str.regexp_string "\n\n"
  |> List.map (fun str ->
         str |> Str.split @@ Str.regexp_string "\n" |> List.map int_of_string)

let%test_unit _ =
  let open Base in
  [%test_result: int list list]
    (input_fake |> from_input_easy)
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

let most_calories_hard input = from_input_hard input |> greatest_sum
let most_calories_easy input = from_input_easy input |> greatest_sum

let rec sum lst =
  match lst with
  | [] -> 0
  | x :: xs -> x + sum xs

let sort_by_sum lst = lst |> List.map sum |> List.sort (fun a b -> b - a)

let%test_unit _ =
  let open Base in
  [%test_result: int list]
    (sort_by_sum [ [ 1; 1 ]; [ 4; 4 ]; [ 8 ]; [ 20 ] ])
    ~expect:[ 20; 8; 8 ]

let top3_calories input =
  let calories = from_input_easy input in
  match sort_by_sum calories with
  | a :: b :: c :: _ -> sum [ a; b; c ]
  | _ -> failwith "wat?"
