(* https://adventofcode.com/2022/day/1 *)

(* UTILS *)

let rec sum lst =
  match lst with
  | [] -> 0
  | x :: xs -> x + sum xs

let%test_unit _ = [%test_eq: Base.int] (sum []) 0
let%test_unit _ = [%test_eq: Base.int] (sum [ 1; 2 ]) 3

(* CONVERT INPUT *)

let from_input input =
  input
  |> Str.split @@ Str.regexp_string "\n\n"
  |> List.map (fun str ->
         str |> Str.split @@ Str.regexp_string "\n" |> List.map int_of_string)

let%test_unit _ =
  let open Base in
  [%test_eq: int list list] (from_input "1\n\n2\n3") [ [ 1 ]; [ 2; 3 ] ]

(* COMPUTE FROM DATA *)

let greatest_sum lst_of_ints =
  List.map sum lst_of_ints |> List.sort (fun a b -> b - a) |> List.hd

let%test_unit _ = [%test_eq: Base.int] (greatest_sum [ [ 1 ]; [ 2; 3 ] ]) 5

let sort_by_sum lst = lst |> List.map sum |> List.sort (fun a b -> b - a)

let%test_unit _ =
  let open Base in
  [%test_eq: int list]
    (sort_by_sum [ [ 1; 1 ]; [ 4; 4 ]; [ 8 ]; [ 20 ] ])
    [ 20; 8; 8; 2 ]

(* Public API *)

(* Find the Elf carrying the most Calories. How many total Calories is that Elf carrying? *)
let most_calories input = input |> greatest_sum

(* Find the total Calories carried by the top three Elves carrying the most Calories *)
let top3_calories input =
  match sort_by_sum input with
  | a :: b :: c :: _ -> sum [ a; b; c ]
  | _ -> raise @@ Invalid_argument "List must contain at least 3 elements"