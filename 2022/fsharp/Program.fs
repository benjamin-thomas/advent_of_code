open Expecto

(*
  dotnet watch run
*)

[<EntryPoint>]
let main args =
  printfn "Running tests..."
  runTestsWithCLIArgs [] args Day01.tests |> ignore
  printfn $"%s{Day01.greet}"
  0
  
