# frozen_string_literal: true

require 'minitest'
require 'minitest/autorun'
require 'lib/day01'

# rg --files lib/ test/ | entr -cr ruby -I .:test ./test/day01_test.rb
class Day01Test < Minitest::Test

  INPUT = <<~INPUT
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
  INPUT

  def setup
    @day = Day01.new(INPUT)
  end

  def test_calories
    expected = [[1000, 2000, 3000], [4000], [5000, 6000], [7000, 8000, 9000], [10_000]]
    assert_equal expected, @day.calories
  end

  def test_most_calories
    assert_equal 24_000, @day.most_calories
  end

  def test_top3_calories
    assert_equal 45_000, @day.top3_calories
  end
end
