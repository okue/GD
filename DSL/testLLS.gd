-- lexicographically largest subsequences

BASETYPE : Int

r : (List Int)->(List Int)->Bool = leq_lexico
q : (List Int)->(List Int)->Bool = leq_lexico

e1 : (List Int) = nil
f1 : Int -> (List Int) -> (List Int) = cons
f2 : Int -> (List Int) -> (List Int) = outr

