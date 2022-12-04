module Day01

/// Greets with style (and documentation)!
let greet = "Hello, day 1!"

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
        ]
