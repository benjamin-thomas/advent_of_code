# frozen_string_literal: true

# ruby -I . ./bin/run.rb

require "lib/day01"
def read(day)
  File.read(File.join("..", "_inputs", day))
end

day_01 = Day01.new(read("day01"))
puts("Day 01")
puts("======")
puts("Answer 1: #{day_01.most_calories}")
puts("Answer 2: #{day_01.top3_calories}")

