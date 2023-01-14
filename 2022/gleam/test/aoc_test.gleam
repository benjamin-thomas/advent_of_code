import gleeunit
import gleeunit/should
import aoc

// rg --files  | grep -F .gleam | entr -rc gleam test

pub const input = "
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
"

pub fn main() {
  gleeunit.main()
}

// pub fn greatest_sum_test() {
//   aoc.sums(input)
//   |> should.equal(Ok([6000, 4000, 11_000, 24_000, 10_000]))
// }

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  aoc.one
  |> should.equal(1)
}

// let result_and_then f ra rb =
//     Result.bind ra (\x ->
//         Result.map rb (\y -> f x y)
//     )

// let compute2 (lst : (Result.t int, 'a) List) =
//     List.fold_right lst ~init:(Result.ok []) ~f:(result_and_then List.cons)

pub fn play_with_bind_test() {
  should.equal(Ok([1, 2, 3]), aoc.compute([Ok(1), Ok(2), Ok(3)]))
  should.equal(Error("oops"), aoc.compute([Ok(1), Error("oops"), Ok(3)]))
}
