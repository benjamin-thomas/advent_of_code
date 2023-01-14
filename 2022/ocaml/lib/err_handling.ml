(* Option.map2 is built into Base *)

let%test_unit _ =
  let open Base in
  [%test_eq: int list option] (Some [ 1; 2; 3 ])
  @@ List.fold_right
       ~f:(Option.map2 ~f:(fun h t -> h :: t))
       [ Some 1; Some 2; Some 3 ] ~init:(Some [])

let result_map2 f ra rb =
  match ra with
  | Error _ as e -> e
  | Ok a -> (
      match rb with
      | Error _ as e -> e
      | Ok b -> Ok (f a b))

let compute1 (lst : (int, 'a) Result.t list) =
  let open Base in
  List.fold_right ~f:(result_map2 List.cons) ~init:(Ok []) lst

let expect_result want got =
  let open Base in
  [%test_eq: (int list, string) Result.t] want got

let%test_unit _ =
  expect_result (Ok [ 1; 2; 3 ]) @@ compute1 [ Ok 1; Ok 2; Ok 3 ]

let%test_unit _ =
  expect_result (Error "oops") @@ compute1 [ Ok 1; Error "oops"; Ok 3 ]

(* NOTE: `then_apply` is result_map2! *)
let then_apply f ra rb =
  let open Base in
  ra |> Result.bind ~f:(fun x -> Result.map ~f:(fun y -> f x y) rb)

let compute2 (lst : (int, 'a) Result.t list) =
  let open Base in
  List.fold_right ~f:(then_apply List.cons) ~init:(Ok []) lst

let%test_unit _ =
  expect_result (Ok [ 1; 2; 3 ]) @@ compute2 [ Ok 1; Ok 2; Ok 3 ]

let%test_unit _ =
  expect_result (Error "oops")
  @@ compute2 [ Ok 1; Error "oops"; Error "oops2"; Ok 4 ]

let compute3 (lst : (int, string) Result.t list) =
  let open Base in
  List.fold_right
    ~f:(fun x acc ->
      match (x, acc) with
      | Ok x, Ok acc -> Ok (x :: acc)
      | Ok _, Error e -> Error e
      | Error e, _ -> Error e)
    ~init:(Ok []) lst

let then_apply2 f ra rb =
  let open Base in
  let open Base.Result.Monad_infix in
  ra >>= fun x -> Result.map ~f:(fun y -> f x y) rb

let compute4 =
  let open Base in
  List.fold_right ~f:(then_apply2 List.cons) ~init:(Ok [])

(*
  >>= is Result.bind
  >>| is Result.map
*)
let then_apply3 f ra rb =
  let open Base.Result.Monad_infix in
  (* let ( >>= ) = Result.bind in *)
  (* let ( >>| ) r f = Result.map f r in *)
  ra >>= fun x ->
  rb >>| fun y -> f x y

(* WOW *)
let map3 f ra rb rc =
  let open Base.Result.Monad_infix in
  ra >>= fun x ->
  rb >>= fun y ->
  rc >>| fun z -> f x y z

let compute5 =
  let open Base in
  List.fold_right ~f:(then_apply3 List.cons) ~init:(Ok [])

let%test_unit _ =
  expect_result (Ok [ 1; 2; 3 ]) @@ compute3 [ Ok 1; Ok 2; Ok 3 ]

let%test_unit _ =
  expect_result (Error "oops")
  @@ compute3 [ Ok 1; Error "oops"; Error "oops2"; Ok 4 ]

let%test_unit _ =
  expect_result (Ok [ 1; 2; 3 ]) @@ compute4 [ Ok 1; Ok 2; Ok 3 ]

let%test_unit _ =
  expect_result (Error "oops")
  @@ compute4 [ Ok 1; Error "oops"; Error "oops2"; Ok 4 ]

let%test_unit _ =
  expect_result (Ok [ 1; 2; 3 ]) @@ compute5 [ Ok 1; Ok 2; Ok 3 ]

let%test_unit _ =
  expect_result (Error "oops")
  @@ compute5 [ Ok 1; Error "oops"; Error "oops2"; Ok 4 ]