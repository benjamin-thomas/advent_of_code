defmodule AocTest do
  use ExUnit.Case
  doctest Aoc

  defp input do
    """
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
    """
  end

  test "to_calories" do
    expected = [[1000, 2000, 3000], [4000], [5000, 6000], [7000, 8000, 9000], [10000]]
    got = Aoc.to_calories(input())

    assert got == expected
  end

  test "most_calories" do
    assert 24000 == Aoc.most_calories(input())
  end

  test "top3_calories" do
    # The sum of the Calories carried by these three elves is 45000.
    assert 45000 == Aoc.top3_calories(input())
  end
end
