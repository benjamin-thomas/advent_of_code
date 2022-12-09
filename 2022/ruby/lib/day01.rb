# frozen_string_literal: true

class Day01
  def initialize(input)
    @input = input
  end

  def calories
    @input
      .split("\n\n")
      .map { |str| str.lines.map(&:to_i) }
  end

  def most_calories
    calories_agg_desc.first
  end

  def top3_calories
    calories_agg_desc.take(3).sum
  end

  private

    def calories_agg_desc
      calories.map(&:sum).sort.reverse
    end
end
