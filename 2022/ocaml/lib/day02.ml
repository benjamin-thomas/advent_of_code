(* dune runtest --watch *)

(*
The winner of the whole tournament is the player with the highest score. Your
total score is the sum of your scores for each round. The score for a single
round is the score for the shape you selected (1 for Rock, 2 for Paper, and 3
for Scissors) plus the score for the outcome of the round (0 if you lost, 3 if
the round was a draw, and 6 if you won).
*)
type choice = Rock | Paper | Scissors [@@deriving sexp, ord]
type round_outcome = Won | Lost | Draw [@@deriving sexp, ord]

let shape_score choice =
  match choice with
  | Rock     -> 1
  | Paper    -> 2
  | Scissors -> 3
  [@@ocamlformat "disable"]

let outcome_score outcome =
  match outcome with
  | Won  -> 6
  | Lost -> 0
  | Draw -> 3
  [@@ocamlformat "disable"]

(*
 Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock. If both
 players choose the same shape, the round instead ends in a draw.
 *)
let outcome_for_round (me, opponent) =
  match (me, opponent) with
  | Rock,     Rock     -> (Rock,     Draw)
  | Paper,    Paper    -> (Paper,    Draw)
  | Scissors, Scissors -> (Scissors, Draw)
  | Rock,     Paper    -> (Rock,     Lost)
  | Paper,    Rock     -> (Paper,    Won)
  | Rock,     Scissors -> (Rock,     Won)
  | Scissors, Rock     -> (Scissors, Lost)
  | Paper,    Scissors -> (Paper,    Lost)
  | Scissors, Paper    -> (Scissors, Won)
  [@@ocamlformat "disable"]

let round_score (shape, outcome) = shape_score shape + outcome_score outcome

type round_outcome_v2 = NeedToLose | NeedToWin | NeedToDraw
[@@deriving sexp, ord]

let convert_to_v1 (_them, need, us) =
  (* (Rock, NeedToDraw, Rock) ->  (Rock, Draw)*)
  match need with
  | NeedToDraw -> (us, Draw)
  | NeedToLose -> (us, Lost)
  | NeedToWin -> (us, Won)

let opponent_shape_for letter =
  match letter with
  | 'A' -> Rock
  | 'B' -> Paper
  | 'C' -> Scissors
  | _ -> failwith @@ Printf.sprintf "Invalid letter: '%c'" letter

let shape_for letter =
  match letter with
  | 'X' -> Rock
  | 'Y' -> Paper
  | 'Z' -> Scissors
  | _ -> failwith @@ Printf.sprintf "Invalid letter: '%c'" letter

let shapes_for_round str =
  let me = String.get str 2 in
  let opponent = String.get str 0 in
  ( shape_for me
  , opponent_shape_for opponent
  )
  [@@ocamlformat "disable"]

(*
  This strategy guide predicts and recommends the following:

  - In the first round, your opponent will choose Rock (A), and you should choose Paper (Y).
    This ends in a win for you with a score of 8 (2 because you chose Paper + 6 because you won).
  - In the second round, your opponent will choose Paper (B), and you should choose Rock (X).
    This ends in a loss for you with a score of 1 (1 + 0).
  - The third round is a draw with both players choosing Scissors, giving you a score of 3 + 3 = 6.

  In this example, if you were to follow the strategy guide, you would get a total score of 15 (8 + 1 + 6).
  *)

open Base

(* let mytest2 = flip Hello = Goodbye *)

(* Error: This expression has type action but an expression was expected of type int *)
(* let%test _ = [%test_eq: action] (flip Hello) = Goodbye *)
(*
Error: Unbound value sexp_of_action => fixed by deriving sexp + adding `sexplib` lib + `ppx_jane` preprocess in dune file
Error: Unbound value compare_action =>
*)
let%test_unit _ = [%test_eq: choice] (opponent_shape_for 'A') Rock
let%test_unit _ = [%test_eq: choice] (opponent_shape_for 'B') Paper
let%test_unit _ = [%test_eq: choice] (opponent_shape_for 'C') Scissors
let%test_unit _ = [%test_eq: choice] (shape_for 'X') Rock
let%test_unit _ = [%test_eq: choice] (shape_for 'Y') Paper
let%test_unit _ = [%test_eq: choice] (shape_for 'Z') Scissors
let%test_unit "1st round (A Y)" = [%test_eq: int] 8 @@ round_score (Paper, Won)

let%test_unit _ =
  [%test_eq: choice * round_outcome]
    (outcome_for_round (Paper, Rock))
    (Paper, Won)

let%test_unit "2nd round (B X)" = [%test_eq: int] 1 @@ round_score (Rock, Lost)

let%test_unit "3rd round (C Z)" =
  [%test_eq: int] 6 @@ round_score (Scissors, Draw)

let%test_unit "1st round (A Y) bis" =
  let me, opponent = shapes_for_round "A Y" in
  let outcome = outcome_for_round (me, opponent) in
  [%test_eq: int] 8 @@ round_score outcome

let%test_unit "2nd round (B X) bis" =
  let me, opponent = shapes_for_round "B X" in
  let outcome = outcome_for_round (me, opponent) in
  [%test_eq: int] 1 @@ round_score outcome

let%test_unit "3rd round (C Z) bis" =
  let me, opponent = shapes_for_round "C Z" in
  let outcome = outcome_for_round (me, opponent) in
  [%test_eq: int] 6 @@ round_score outcome

let rounds input =
  let helper str =
    str |> shapes_for_round |> outcome_for_round |> round_score
  in
  input |> List.map ~f:helper

let%test_unit "All rounds" =
  let input = [ "A Y"; "B X"; "C Z" ] in
  let res = rounds input in
  [%test_eq: int list] res @@ [ 8; 1; 6 ]

let from_input str = str |> Str.split @@ Str.regexp "\n"

let%test_unit "from_input" =
  let input = {|
A Y
B X
C Z
|} in
  [%test_eq: string list] [ "A Y"; "B X"; "C Z" ] @@ from_input input

(* X means you need to lose,
   Y means you need to end the round in a draw, and
   Z means you need to win. Good luck! *)

let need_to letter =
  match letter with
  | 'X' -> NeedToLose
  | 'Y' -> NeedToDraw
  | 'Z' -> NeedToWin
  | _ -> failwith @@ Printf.sprintf "Invalid letter: '%c'" letter

let outcome_v2 them need =
  match need with
  | NeedToDraw -> (
      match them with
      | Rock -> Rock
      | Paper -> Paper
      | Scissors -> Scissors)
  | NeedToWin -> (
      match them with
      | Rock -> Paper
      | Paper -> Scissors
      | Scissors -> Rock)
  | NeedToLose -> (
      match them with
      | Rock -> Scissors
      | Paper -> Rock
      | Scissors -> Paper)

(*
In the first round, your opponent will choose Rock (A), and you need the round
to end in a draw (Y), so you also choose Rock.

This gives you a score of 1 + 3 = 4.
*)
let convert op need =
  let them = opponent_shape_for op in
  let need = need_to need in
  let mine = outcome_v2 them need in
  (them, need, mine)

let rounds_v2 input =
  let helper x =
    convert (String.get x 0) (String.get x 2) |> convert_to_v1 |> round_score
  in
  input |> List.map ~f:helper

let%test_unit "All rounds v2" =
  let input = [ "A Y"; "B X"; "C Z" ] in
  let res = rounds_v2 input in
  [%test_eq: int list] res @@ [ 4; 1; 7 ]

let%test_unit "1st round (A Y) v2a" =
  [%test_eq: choice * round_outcome_v2 * choice] (Rock, NeedToDraw, Rock)
  @@ convert 'A' 'Y'

let%test_unit "1st round (A Y) v2b" =
  [%test_eq: int] 4 @@ round_score @@ convert_to_v1 (Rock, NeedToDraw, Rock)

(* In the second round, your opponent will choose Paper (B),
   and you choose Rock so you lose (X) with a score of 1 + 0 = 1. *)
let%test_unit "2nd round (B X) v2a" =
  [%test_eq: choice * round_outcome_v2 * choice] (Paper, NeedToLose, Rock)
  @@ convert 'B' 'X'

let%test_unit "2nd round (B X) v2b" =
  [%test_eq: int] 1 @@ round_score @@ convert_to_v1 (Paper, NeedToLose, Rock)

(* In the third round, you will defeat your opponent's Scissors with Rock for a score of 1 + 6 = 7.   *)
let%test_unit "3rd round (B X) v3a" =
  [%test_eq: choice * round_outcome_v2 * choice] (Scissors, NeedToWin, Rock)
  @@ convert 'C' 'Z'

let%test_unit "3rd round (B X) v3b" =
  [%test_eq: int] 7 @@ round_score @@ convert_to_v1 (Scissors, NeedToWin, Rock)
