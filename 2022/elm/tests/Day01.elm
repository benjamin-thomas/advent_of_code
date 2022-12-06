module Day01 exposing (..)

import Expect
import Inputs
import Test exposing (..)



{-
   rg --files src/ tests/ | entr -c elm-test
-}


fromInput : String -> List Int
fromInput str =
    str
        |> String.split "\n\n"
        |> List.map
            (String.lines
                >> List.filterMap String.toInt
                >> List.sum
            )
        |> List.sort
        |> List.reverse


mostCalories : List Int -> Maybe Int
mostCalories lst =
    List.head lst


top3calories : List number -> number
top3calories lst =
    lst |> List.take 3 |> List.sum


suite : Test
suite =
    describe "Day 01"
        [ test "fromInput" <|
            \_ ->
                Expect.equal [ 15, 4, 3 ] <|
                    fromInput "1\n2\n\n4\n\n4\n5\n6"
        , test "mostCalories" <|
            \_ ->
                Expect.equal (Just 15) <|
                    (fromInput "1\n2\n\n4\n\n4\n5\n6" |> mostCalories)
        , test "answer1" <|
            \_ ->
                Expect.equal (Just 75622) <|
                    (fromInput Inputs.day01 |> mostCalories)
        , test "top3calories" <|
            \_ ->
                -- 20 + 15 + 4
                Expect.equal 39 <|
                    (fromInput "1\n2\n\n4\n\n4\n5\n6\n\n20" |> top3calories)
        , test "answer2" <|
            \_ ->
                Expect.equal 213159 <|
                    (fromInput Inputs.day01 |> top3calories)
        ]
