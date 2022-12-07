# https://www.roc-lang.org/tutorial
# https://github.com/roc-lang/roc/blob/main/examples/cli/file.roc

# echo main.roc | entr -c roc dev

app "aoc"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.1.1/zAoiC9xtQPHywYk350_b7ust04BmWLW00sjb9ZPtSQk.tar.br" }
    imports  [ pf.Stdout
             , pf.Stderr
             , pf.File
             , pf.Task.{ Task }
             , pf.Path
             ]
    provides [main] to pf


readFile = \day ->
    File.readUtf8 (Str.concat "../_inputs/" day |> Path.fromStr)


fromInput = \str ->
    str
    |> Str.split "\n\n"
    |> List.map (\s ->
        s
        |> Str.split "\n"
        |> List.map (\n -> Str.toNat n |> Result.withDefault 0)
        |> List.sum)
    |> List.sortDesc

answer1 =
    List.first

answer2 = \input ->
    input
    |> List.takeFirst 3
    |> List.sum

main : Task {} []
main =
    day = "day01"
    Task.attempt (readFile day) \result ->
        when result is
            Ok content ->
                input = fromInput content
                res1 = Str.concat "Answer 1: " (Num.toStr (answer1 input |> Result.withDefault 0))
                res2 = Str.concat "Answer 2: " (Num.toStr (answer2 input))
                Stdout.line (Str.joinWith [res1, res2] "\n")
            Err _ -> Stderr.line (Str.concat "Could not read file: " day)