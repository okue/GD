-- 0-1 knapsack problem

BASETYPE : Pair Int Int
LEFT     : [e1]
RIGHT    : [f1,f2]
INPUT : [ (50,4),(3,12),(1,1),(10,5),(4,31),(4,2)]


pairPlus p1 p2 :
  (Int,Int)->(Int,Int)->(Int,Int) =
  (fst p1 + fst p2 , snd p1 + snd p2)

pairSum : (List (Int,Int))->(Int,Int) = foldr pairPlus (0,0)

sumVal x : (List (Int,Int))->Int = fst (pairSum x)

sumWt x : (List (Int,Int))->Int = snd (pairSum x)

w : Int = 10

p x : (List (Int,Int))->Bool = leq (sumWt x) w

r a b :
  (List (Int,Int))->(List (Int,Int))->Bool =
  leq (sumVal a) (sumVal b)

q a b :
  (List (Int,Int))->(List (Int,Int))->Bool =
  (leq (sumVal a) (sumVal b)) && ((sumWt a) == (sumWt b))

e1 : (List (Int,Int)) = nil
f1 : ((Int,Int),(List (Int,Int))) -> (List (Int,Int)) = cons
f2 : ((Int,Int),(List (Int,Int))) -> (List (Int,Int)) = outr
