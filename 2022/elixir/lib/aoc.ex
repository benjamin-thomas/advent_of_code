defmodule Aoc do
  # rg --files lib/ test/ | entr -cr mix test

  @moduledoc """
  Documentation for `Aoc`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Aoc.to_calories("1\\n\\n2\\n3")
      [[1], [2, 3]]

  """
  def to_calories(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(fn str ->
      String.split(str, "\n")
      |> Enum.map(fn s -> String.to_integer(s) end)
    end)
  end

  def most_calories(input) do
    calories_agg_desc(input)
    |> hd
  end

  def top3_calories(input) do
    calories_agg_desc(input) |> Enum.take(3) |> Enum.sum()
  end

  defp calories_agg_desc(input) do
    to_calories(input)
    |> Enum.map(fn cals -> Enum.sum(cals) end)
    |> Enum.sort(:desc)
  end
end
