module Day01 where

import Control.Arrow ((>>>))
import Data.List (sort)
import Data.List.Split (splitOn)
import Prelude hiding ((>>))

{-
rg --files | entr -c doctest ./src/
rg --files | entr -c cabal repl --with-ghc=doctest
rg --files | entr -c cabal exec -- doctest src/
-}

{- | dropWhileEnd was originally defined in the now deprecated module `GHC.OldList`.

     See:
        https://mail.haskell.org/pipermail/libraries/2014-September/023840.html
-}
dropWhileEnd' :: Foldable t => (a -> Bool) -> t a -> [a]
dropWhileEnd' p = foldr (\x r -> if p x && null r then [] else x : r) []

{- |
>>> chomp "\n\nA\nB\n\n"
"A\nB"
-}
chomp :: String -> String
chomp =
    dropWhile (== '\n') . dropWhileEnd' (== '\n')

{- |

>>> fromInput "1\n\n2\n3"
[[1],[2,3]]
>>> fromInput "1\n\n2\n3\n"
[[1],[2,3]]
-}
fromInput :: String -> [[Integer]]
fromInput input =
    map (map read . splitOn "\n") (splitOn "\n\n" (chomp input))

{- |

>>> greatestSum [[1],[2,3]]
5
-}
greatestSum :: [[Integer]] -> Integer
greatestSum = head . (reverse . sort) . map sum

{- |
>>> sort [3,1,2]
[1,2,3]
>>> reverse << sort $ [3,1,2]
[3,2,1]
>>> reverse . sort $ [3,1,2]
[3,2,1]
>>> sort >> reverse $ [3,1,2]
[3,2,1]
-}

-- Same as: Prelude.(.)
(<<) :: (t1 -> t2) -> (t3 -> t1) -> t3 -> t2
(<<) f g x = f (g x)

-- Same as: Control.Arrow.(>>>)
(>>) :: (t1 -> t2) -> (t2 -> t3) -> t1 -> t3
(>>) f g x = g (f x)

{- |
>>> top3Calories [[1,2], [4], [5], [9], [2,1]]
18
-}
top3Calories :: [[Integer]] -> Integer
top3Calories = map sum >>> sort >>> reverse >>> take 3 >>> sum

{-
    Previous iterations, keeping for ref:

    top3Calories calories = sum (take 3 (reverse (sort (map sum calories))))
    top3Calories calories = sum $ take 3 $ reverse $ sort $ map sum calories
    top3Calories = sum . take 3 . reverse . sort . map sum
 -}
