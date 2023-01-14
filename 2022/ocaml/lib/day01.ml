(* https://adventofcode.com/2022/day/1 *)

(* UTILS *)

[@@@warning "-32"]

let result_map2 f ra rb =
  match ra with
  | Error _ as e -> e
  | Ok a -> (
      match rb with
      | Error _ as e -> e
      | Ok b -> Ok (f a b))

let testing () =
  let _three = result_map2 ( + ) (Ok 1) (Ok 2) in
  let _fail_1 = result_map2 ( + ) (Error "oops") (Ok 2) in
  let _fail_2 = result_map2 ( + ) (Ok 1) (Error "oops") in
  let _compute_chain_fails =
    List.fold_right (result_map2 List.cons) [ Ok 1; Ok 2 ] (Error "Oops")
  in
  let _compute_chain_succeeds =
    List.fold_right (result_map2 List.cons) [ Ok 1; Ok 2 ] (Ok [])
  in
  ()

let%test_unit _ =
  let open Base in
  let x : int option = Some 1 in
  let _y : (int, string) Result.t = Ok 1 in
  [%test_eq: int option] x @@ Some 1

let%test_unit _ =
  let open Base in
  let x : (int, string) Result.t = Ok 1 in
  [%test_eq: (int, string) Result.t] x @@ Ok 1

let compute (lst : (int, 'a) Result.t list) =
  let open Base in
  List.fold_right ~f:(result_map2 List.cons) lst ~init:(Ok [])

let expect_result want got =
  let open Base in
  [%test_eq: (int list, string) Result.t] want got

let%test_unit _ = expect_result (Ok [ 1; 2; 3 ]) @@ compute [ Ok 1; Ok 2; Ok 3 ]

let%test_unit _ =
  expect_result (Error "oops") @@ compute [ Ok 1; Error "oops"; Ok 3 ]

let%test_unit _ =
  let open Base in
  [%test_eq: int list option] (Some [ 1; 2; 3 ])
  @@ List.fold_right
       ~f:(Option.map2 ~f:(fun h t -> h :: t))
       [ Some 1; Some 2; Some 3 ] ~init:(Some [])

let rec sum lst =
  match lst with
  | [] -> 0
  | x :: xs -> x + sum xs

let%test_unit _ = [%test_eq: Base.int] (sum []) 0
let%test_unit _ = [%test_eq: Base.int] (sum [ 1; 2 ]) 3

(* CONVERT INPUT *)

let from_input (input : string) : int list list option =
  try
    let res =
      input
      |> Str.split @@ Str.regexp_string "\n\n"
      |> List.map (fun str ->
             str
             |> Str.split @@ Str.regexp_string "\n"
             |> List.map int_of_string)
    in
    Some res
  with
  | Failure _ -> None

let%test_unit _ =
  let open Base in
  [%test_eq: int list list option] (from_input "1\n\n2\n3")
  @@ Some [ [ 1 ]; [ 2; 3 ] ]

let%test_unit _ =
  let open Base in
  [%test_eq: int list list option] (from_input "1\n\n2a\n3") @@ None

(* ORIG *)

let from_input (input : string) =
  input
  |> Str.split @@ Str.regexp_string "\n\n"
  |> List.map (fun str ->
         str |> Str.split @@ Str.regexp_string "\n" |> List.map int_of_string)

(* Simplify *)

let from_input2 input =
  try
    let lst = input |> Str.split @@ Str.regexp_string " " in
    let res = lst |> List.map int_of_string in
    Some res
  with
  | Failure _ -> None

let from_input2 input =
  let rec inner lst acc =
    match lst with
    | [] -> Some (List.rev acc)
    | h :: t -> (
        match int_of_string_opt h with
        | None -> None
        | Some h -> inner t (h :: acc))
  in
  let lst = input |> Str.split @@ Str.regexp_string " " in
  inner lst []

let%test_unit _ =
  let open Base in
  [%test_eq: int list option] (from_input2 "1 2 3") @@ Some [ 1; 2; 3 ]

let%test_unit _ =
  let open Base in
  [%test_eq: int list option] (from_input2 "1 2a 3") @@ None

let from_input3 lst =
  let rec inner lst acc =
    match lst with
    | [] -> Some (List.rev acc)
    | h :: t -> (
        match h with
        | None -> None
        | Some h -> inner t (h :: acc))
  in
  inner lst []

let%test_unit _ =
  let open Base in
  [%test_eq: int list option] (from_input3 [ Some 1; Some 2; Some 3 ])
  @@ Some [ 1; 2; 3 ]

let%test_unit _ =
  let open Base in
  [%test_eq: int list option] (from_input3 [ Some 1; None; Some 3 ]) @@ None

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

(* Bind  *)

(* let%test_unit _ =
   [%test_eq: Base.int Base.list Base.option] None
   @@ List.fold_right
        (Option.map2 ~f:(fun h t -> h :: t))
        ~init:(Some []) [ Some 1; None; Some 3 ] *)

open Base

let ( === ) = [%test_eq: int list option]

let%test_unit _ = Some [ 1; 2; 3 ] === Some [ 1; 2; 3 ]

let%test_unit _ =
  [%test_eq: int option] (Some 4)
  @@ Option.bind ~f:(fun x -> Some (x * 2)) (Some 2)

let%test_unit _ =
  [%test_eq: int option] (Some 4) @@ Option.map ~f:(fun x -> x * 2) (Some 2)

let%test_unit _ =
  [%test_eq: int option] None @@ Option.map ~f:(fun x -> x * 2) None

let%test_unit _ =
  [%test_eq: int option] None @@ Option.map2 ~f:(fun x y -> x + y) None None

let%test_unit _ =
  [%test_eq: int option] None @@ Option.map2 ~f:(fun x y -> x + y) (Some 1) None

let%test_unit _ =
  [%test_eq: int option] None @@ Option.map2 ~f:(fun x y -> x + y) None (Some 1)

let%test_unit _ =
  [%test_eq: int option] (Some 3)
  @@ Option.map2 ~f:(fun x y -> x + y) (Some 1) (Some 2)

let%test_unit _ =
  [%test_eq: int option] (Some 3) @@ Option.map2 ~f:( + ) (Some 1) (Some 2)

let%test_unit _ =
  [%test_eq: int list option] (Some [ 1; 2; 3 ])
  @@ List.fold_right
       ~f:(Option.map2 ~f:(fun h t -> h :: t))
       ~init:(Some []) [ Some 1; Some 2; Some 3 ]

let%test_unit _ =
  [%test_eq: int list option] None
  @@ List.fold_right
       ~f:(Option.map2 ~f:(fun h t -> h :: t))
       ~init:(Some []) [ Some 1; None; Some 3 ]

let x = Result.map

(*
map : (a -> value) -> Result x a -> Result x value
map func ra =
  case ra of
    Ok a ->
      Ok (func a)

    Err e ->
      Err e
*)
let map f = function
  | Ok v -> Ok (f v)
  | Error _ as e -> e

(*
map2 : (a -> b -> value) -> Result x a -> Result x b -> Result x value
map2 func ra rb =
  case ra of
    Err x ->
      Err x

    Ok a ->
      case rb of
        Err x ->
          Err x

        Ok b ->
          Ok (func a b)
*)

(* let map2 fn h t =
   let bind b a = Result.bind a ~f:b in
   h
   |> bind (fun x -> Ok (x, t))
   |> bind (fun (x, t') -> t' |> bind (fun lst -> Ok (fn x lst))) *)
