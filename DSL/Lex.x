{
module Lex where
import qualified Token as T
}
%wrapper "basic"

$digit = [0-9]
$lower = [a-z]
$alpha = [a-zA-Z]
$eol   = [\n]

tokens :-
    $eol+ { \s -> T.Eol }
    $white+ ;
    "(" { \s -> T.Lparen }
    ")" { \s -> T.Rparen }
    "[" { \s -> T.Lparen2 }
    "]" { \s -> T.Rparen2 }
    "foldr" { \s -> T.Foldr }
    "True" { \s -> T.Bool True }
    "False" { \s -> T.Bool False }
    $digit+ { \s -> T.Int (read s) }
    "-" { \s -> T.Minus }
    "+" { \s -> T.Plus }
    "*" { \s -> T.Times }
    "==" { \s -> T.Eq }
    "<=" { \s -> T.Leq }
    "||" { \s -> T.Or }
    "&&" { \s -> T.And }
    "if" { \s -> T.If }
    "then" { \s -> T.Then }
    "else" { \s -> T.Else }
    "Int" { \s -> T.TyInt }
    "Bool" { \s -> T.TyBool }
    "List" { \s -> T.TyList }
    "Pair" { \s -> T.TyPair }
    "->" { \s -> T.Arrow }
    "." { \s -> T.Dot }
    "," { \s -> T.Comma }
    ":" { \s -> T.Colon }
    "=" { \s -> T.Assign }
    "--" { \s -> T.CommentOut }
    "ITYPE" { \s -> T.Itype }
    "OTYPE" { \s -> T.Otype }
    "BASE" { \s -> T.LLabel }
    "STEP" { \s -> T.RLabel }
    "INSTANCE" { \s -> T.Instance }
    $lower [$alpha $digit \_ \’]* { \s -> T.Var s }

{
scanTokens = alexScanTokens
}
