module Main where

import qualified Day01
import System.IO (IOMode (ReadMode), hClose, hGetContents, openFile)

main :: IO ()
main = do
    handle <- openFile "../inputs/day01" ReadMode
    input <- hGetContents handle
    let input' = Day01.fromInput input
    let answer1 = Day01.greatestSum input'
    putStrLn $ "Answer 1 is: " ++ show answer1
    let answer2 = Day01.top3Calories input'
    putStrLn $ "Answer 2 is: " ++ show answer2
    hClose handle
