import gleam/io
import gleam/string
import gleam/list
import gleam/int
import gleam/function
import gleam/bool
import gleam/result

pub const one = 1

// pub fn compute(lst) {
//   list.fold_right(lst, Ok([]), then_cons)
// }

pub fn compute(lst) {
  // rt -> Result of the tail
  // rh -> Result of the head
  list.fold_right(lst, Ok([]), fn(rt, rh) { then_apply(list.prepend, rt, rh) })
}

fn then_apply(f, rt, rh) {
  rt
  |> result.then(fn(t) {
    rh
    |> result.map(fn(h) { f(t, h) })
  })
}

// fn then_cons(
//   ra: Result(List(Int), String),
//   rb: Result(Int, String),
// ) -> Result(List(Int), String) {
//   ra
//   |> result.then(fn(t: List(Int)) {
//     rb
//     |> result.map(fn(h: Int) { list.prepend(t, h) })
//   })
// }

// fn res_and_then(f, ra: Result(List(Int), String), rb: Result(Int, String)) {
//   ra
//   |> result.then(fn(x) {
//     rb
//     |> result.map(fn(y) { f(x, y) })
//   })
// }

// fn to_int(str: String) -> Result(Int, String) {
//   case int.parse(str) {
//     Ok(n) -> Ok(n)
//     Error(_) -> Error("Bad number from string: " <> str)
//   }
// }

// [5000, 4000, 11_000, 24_000, 10_000]
// pub fn sums(input) -> Result(List(Int), String) {
//   let res: List(Result(Int, Nil)) =
//     input
//     |> string.split("\n\n")
//     |> list.map(fn(group) {
//       group
//       |> string.split("\n")
//       |> list.filter(function.compose(string.is_empty, bool.negate))
//       |> list.map(int.parse)
//     })
//     |> list.map(fn(elems: List(Result(Int, Nil))) {
//       elems
//       |> list.fold(
//         Ok(0),
//         fn(acc: Result(Int, Nil), item: Result(Int, Nil)) {
//           case item {
//             Ok(n) ->
//               case acc {
//                 Ok(acc2) -> Ok(acc2 + n)
//                 Error(e) -> Error(e)
//               }
//             Error(e) -> Error(e)
//           }
//         },
//       )
//     })

//   //
//   Error("WIP")
// }

pub fn sums(input) -> Result(List(Int), String) {
  let res: List(List(Result(Int, Nil))) =
    input
    |> string.split("\n\n")
    |> list.map(fn(group) {
      group
      |> string.split("\n")
      |> list.filter(function.compose(string.is_empty, bool.negate))
      |> list.map(int.parse)
    })

  let has_error: Bool =
    res
    |> list.any(fn(lst) {
      lst
      |> list.any(result.is_error)
    })

  // This imperative style here is no good!
  // I need to transform List(List(Result(Int, Nil))) to Result(List(Int), Nil)
  case has_error {
    True -> Error("Bad data")
    False -> Ok([])
  }
  // case elem {
  //   Error(_) -> True
  //   Ok(_) -> False
  // }
  // let res2 = case res
  // |> list.map(fn(elems: Result(List(Int), String)) { Error("WIP") })
  //
}

pub fn main() {
  io.println("Hello from aoc!")
}
