module Day01 exposing (..)

import Expect
import Inputs
import Test exposing (..)



{-
   rg --files src/ tests/ | entr -c elm-test
-}


compute1 : List (Result error a) -> Result error (List a)
compute1 =
    List.foldr (Result.map2 (::)) (Ok [])


compute2a : List (Result error a) -> Result error (List a)
compute2a =
    List.foldl
        (\ra rb ->
            rb |> Result.andThen (\y -> ra |> Result.map (\x -> x :: y))
        )
        (Ok [])
        >> Result.map List.reverse


{-| NOTE: `thenApply` is Result.map2!
-}
thenApply : (a -> b -> c) -> Result x a -> Result x b -> Result x c
thenApply f ra rb =
    ra |> Result.andThen (\x -> rb |> Result.map (\y -> f x y))


compute2b : List (Result error a) -> Result error (List a)
compute2b =
    List.foldr (thenApply (::)) (Ok [])


compute2c : List (Result error a) -> Result error (List a)
compute2c =
    List.foldr (\ra rb -> ra |> Result.andThen (\x -> rb |> Result.map (\y -> x :: y))) (Ok [])


explore : Test
explore =
    concat <|
        List.indexedMap (\i exp -> test ("explore" ++ String.fromInt i) <| exp)
            [ \_ ->
                Just 2 |> Maybe.map ((*) 2) |> Expect.equal (Just 4)
            , \_ ->
                Nothing |> Maybe.map ((*) 2) |> Expect.equal Nothing
            , \_ ->
                Ok 2 |> Result.map ((*) 2) |> Expect.equal (Ok 4)
            , \_ ->
                Err "oops" |> Result.map ((*) 2) |> Expect.equal (Err "oops")
            , \_ ->
                Expect.equal [ Just 2, Nothing, Just 6 ] <|
                    ([ Just 1, Nothing, Just 3 ] |> List.map (Maybe.map ((*) 2)))
            , \_ ->
                Expect.equal [ Nothing ] <|
                    ([ Nothing ] |> List.map (Maybe.map ((*) 2)))
            , \_ ->
                Expect.equal (Just [ 1, 2, 3 ]) <|
                    List.foldr (Maybe.map2 (\h t -> h :: t)) (Just []) [ Just 1, Just 2, Just 3 ]
            , \_ ->
                Expect.equal (Just [ 1, 2, 3 ]) <|
                    List.foldr (Maybe.map2 (::)) (Just []) [ Just 1, Just 2, Just 3 ]
            , \_ ->
                Expect.equal Nothing <|
                    List.foldr (Maybe.map2 (::)) (Just []) [ Just 1, Nothing, Just 3 ]
            , \_ ->
                Expect.equal (Ok [ 1, 2, 3 ]) <|
                    compute1 [ Ok 1, Ok 2, Ok 3 ]
            , \_ ->
                Expect.equal (Err "foo") <|
                    compute1 [ Ok 1, Err "foo", Err "bar10" ]
            , \_ ->
                Expect.equal (Ok [ 1, 2, 3 ]) <|
                    compute2a [ Ok 1, Ok 2, Ok 3 ]
            , \_ ->
                Expect.equal (Err "foo") <|
                    compute2a [ Ok 1, Err "foo", Err "bar12", Ok 4 ]
            , \_ ->
                Expect.equal (Ok [ 1, 2, 3 ]) <|
                    compute2b [ Ok 1, Ok 2, Ok 3 ]
            , \_ ->
                Expect.equal (Err "foo") <|
                    compute2b [ Ok 1, Err "foo", Err "bar14" ]
            , \_ ->
                Expect.equal (Ok [ 1, 2, 3 ]) <|
                    compute2c [ Ok 1, Ok 2, Ok 3 ]
            , \_ ->
                Expect.equal (Err "foo") <|
                    compute2c [ Ok 1, Err "foo", Err "bar16", Ok 4 ]
            ]


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
