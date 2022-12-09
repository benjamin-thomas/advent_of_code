# mix run bin/run.exs

defmodule Utils do
  def read(day) do
    File.read("../_inputs/#{day}")
  end
end

IO.puts("\n")
IO.puts("Day 01")
IO.puts("======")
{:ok, day01} = Utils.read("day01")
IO.puts("Answer 1 = #{Aoc.most_calories(day01)}")
IO.puts("Answer 2 = #{Aoc.top3_calories(day01)}")
IO.puts("\n---\n")
