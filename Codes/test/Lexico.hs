module Lexico where

import DataStructure
import Data.List (union)

-- Lexicographically Largest Subsequences

string1 = toT "uehrg"

-- global criterion
r = (<)
-- local criterion
q = (<)

lls_naive :: T Char -> T Char
lls_naive = maxSet (<) . subsequences

-- ver. thinning
-- max r . (| thin q . s |)
lls_thinning = maxSet r . foldF f
  where f Nil = wrap $ InT Nil
        f (Cons a xs) =
          let tuple = ( [ InT (Cons a x) | x <- xs ] , xs )
          in thinSet q . merge r $ tuple

lls_greedy = foldF f
  where f Nil = InT Nil
        f (y@(Cons a xs)) =
          let ss = [ InT y , xs ]
          in maxSet r ss

-------------------------------------------------

main :: IO()
main = do
  let funs = [ lls_naive, 
               lls_thinning, 
               lls_greedy]
  mapM_ (print.fromT) $ do
    fun <- funs
    return $ fun string1
