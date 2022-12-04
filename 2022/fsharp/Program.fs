open Expecto

(*
  dotnet watch run
*)

[<EntryPoint>]
let main args =
  printfn "Running tests..."
  runTestsWithCLIArgs [] args Day01.tests |> ignore
  let input = System.IO.File.ReadAllText "../inputs/day01"
  let input = Day01.fromInput input
  let answer1 = Day01.mostCalories input
  printfn $"Answer 1: %d{answer1}"
  let answer2 = Day01.top3calories input
  printfn $"Answer 2: %d{answer2}"
  0
  
