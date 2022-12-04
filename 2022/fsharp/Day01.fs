module Day01

/// Greets with style (and documentation)!
let greet = "Hello, day 1!"

let trim (str: string) = str.Trim()
let split (str: string) (x: string) = x.Split(str) |> Array.toList

let fromInputVerbose (s: string) =
    s
    |> trim
    |> split "\n\n"
    |> List.map (fun entry -> entry |> split "\n" |> List.map int)

let to_ints = split "\n" >> List.map int

let fromInput =
    trim >> split "\n\n" >> List.map to_ints

let mostCalories =
    List.map List.sum
    >> List.sortDescending
    >> List.head

// Useful!! Keeping for ref!
let debugPipe x =
    printfn $"==> DEBUG: {x}"
    x

let top3calories =
    List.map List.sum
    >> List.sortDescending
    >> List.take 3
    >> debugPipe
    >> List.sum

open Expecto

let tests =
    testList
        "Day 01"
        [
            test "Can greet" { Expect.equal greet "Hello, day 1!" "Greeting failed, somehow!" }
            test "Can do math" {
                Expect.equal 2 (1 + 1) "wat?"
                Expect.equal 4 (2 + 2) "wat??"
            }
            test "fromInput" { Expect.equal [ [ 1 ]; [ 2; 3 ]; [ 4 ] ] (fromInputVerbose "1\n\n2\n3\n\n4") "" }
            test "fromInput' (terser)" {
                Expect.equal [ [ 1 ]; [ 2; 3 ]; [ 4 ] ] (fromInputVerbose "1\n\n2\n3\n\n4") ""
            }
            test "fromInput with unclean data" {
                Expect.equal [ [ 1 ]; [ 2; 3 ]; [ 4 ] ] (fromInputVerbose "\n1\n\n2\n3\n\n4\n") ""
            }

            test "most calories" {
                Expect.equal 5
                <| mostCalories [ [ 1 ]; [ 2; 3 ]; [ 4 ] ]
                <| ""
            }

            test "top 3 calories" {
                Expect.equal 19
                <| top3calories [ [ 1 ]
                                  [ 2; 4 ] // a
                                  [ 4 ]
                                  [ 8 ] // b
                                  [ 5 ] // c
                                  [ 1; 1; 1 ] ]
                <| "6+8+5=19 (a+b+c)"
            }
        ]
