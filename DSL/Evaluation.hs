module Evaluation (evalFile,eval) where

import Base
import Lex
import Parse
import Syntax
import Data.Map as Map
import Debug.Trace

evalFile s = eval.parse.scanTokens <$> readFile s

eval prog = case prog of
  Reject err -> show err
  Accept (Program ss) -> unlines $ fmap eval_ ss

eval_ CommentOut = ""
eval_ (BIND varName varType varExpr) = case varExpr of
  NAT _ -> (declareConst varName varType varExpr)
  B _   -> (declareConst varName varType varExpr)
  PAIR _ _ -> (declareConst varName varType varExpr)
  VAR _ -> (declareFun varName varType varExpr)
  _ -> ""

-- (declare-const x typ)
-- (assert (= x v))
declareConst x typ v = a1 ++ "\n" ++ a2
  where
    a1 = "(declare-const " ++ x ++ " " ++ showType typ ++ ")"
    a2 = "(assert (= " ++ x ++ " " ++ showExpr v ++ "))"

-- (declare-const x typ)
-- (assert (= x v))
declareFun x typ v = a1 ++ "\n" ++ a2 ++ "\n" ++ a3
  where
    a1 = "(declare-fun " ++ x ++ " " ++ showType typ ++ ")"
    a2 = "(assert (forall (" ++ (argsTuple typ) ++ ")"
    a3 = ""
    argsTuple as = concat $ zipWith aux argSequence ((fmap showType).init.args $ as)
      where
        aux x t = "(" ++ x ++ " " ++ t ++ ")"
        argSequence = fmap (\i -> "x" ++ show i) [1..]
        args (FUN a b) = a : args b
        args others    = [others]





ss = [ "",
       "x : Int = 1",
       "b : Bool = True",
       "p1 :(Pair Int Int) = (1,2)",
       "f1 : Int -> (List Int) -> List Int = cons",
       "pairPlus : (Pair Int Int)->(Pair Int Int)->(Pair Int Int) ="++
       "\\p1:(Pair Int Int). \\p2:(Pair Int Int). (fst p1,snd p2)",
       -- "sum : (List Int) -> Int = foldr plus 0",
       "" ]

main :: IO()
main = do
  putStrLn $ eval.parse.scanTokens $ unlines ss
  print 0
