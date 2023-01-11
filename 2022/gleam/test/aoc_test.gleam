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

pub fn greatest_sum_test() {
  aoc.sums(input)
  |> should.equal([6000, 4000, 11_000, 24_000, 10_000])
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  aoc.one
  |> should.equal(1)
}
