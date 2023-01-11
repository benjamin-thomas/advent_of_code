import gleam/io
import gleam/string
import gleam/list
import gleam/int
import gleam/function
import gleam/bool

pub const one = 1

fn to_int(str: String) -> Int {
  case int.parse(str) {
    Ok(n) -> n
    Error(_) -> -1
  }
}

// [5000, 4000, 11_000, 24_000, 10_000]
pub fn sums(input) {
  input
  |> string.split("\n\n")
  |> list.map(fn(group) {
    group
    |> string.split("\n")
    |> list.filter(function.compose(string.is_empty, bool.negate))
    |> list.map(to_int)
    |> list.fold(0, fn(acc, n) { acc + n })
  })
}

pub fn main() {
  io.println("Hello from aoc!")
}
