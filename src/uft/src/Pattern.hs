module Pattern where

type VCon = String
type Name = String

data Pat = Apply VCon [Pat]
         | Var Name
         | Wildcard
         deriving (Eq)
    --    N.B. a pattern for literal integer k is represented
    --    as APPLY (Int.toString k, [])

instance Show Pat where
  show (Apply vcon []) = vcon
  show (Apply vcon pats) = "(" ++ vcon ++ " " ++ show pats ++ ")"
  show (Var x) = x
  show Wildcard = "_"

instance Ord Pat where
  Wildcard <= _ = True
  Var x <= Var y = x <= y
  Apply x _ <= Apply y _ = x <= y 
  _ <= _ = False

bound :: Pat -> [Name]
bound p = addBound p []

addBound :: Pattern.Pat -> [Name] -> [Name]
addBound (Apply vcon pats) vars = foldr addBound vars pats
addBound Wildcard vars = vars
addBound (Var x) vars = x:vars
