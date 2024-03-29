-- elimination form for constructed data
module Case where

import qualified Pattern as P
import qualified Data.Set as Set
import qualified Error as E


type Name = P.Name

data T exp = T exp [(P.Pat, exp)] deriving Show

instance Functor T where
  fmap f (T e choices) = T (f e) (map (\(p, e) -> (p, f e)) choices)

instance Foldable T where
  foldr f z (T e choices) = foldr (\(p, e) z -> f e z) (f e z) choices

fold :: ((exp, a) -> a) -> a -> T exp -> a
fold = undefined

patBound p = case p of
  P.Apply _ ps -> Set.unions (map patBound ps)
  P.Var x -> Set.singleton x
  P.Wildcard -> Set.empty

free :: (exp -> Set.Set Name) -> (T exp -> Set.Set Name)
free subFree (T e choices) =
  let freeChoice (p, e) = subFree e Set.\\ patBound p
  in Set.unions (subFree e : map freeChoice choices)

liftError :: T (E.Error a) -> E.Error (T a)
liftError (T (E.Error (Left msg)) _) = E.Error $ Left msg
liftError (T (E.Error (Right e)) choices) = 
    let choice (p, E.Error (Right e)) = E.Error $ Right (p, e)
        choice (_, E.Error (Left msg)) = E.Error $ Left msg
    in case E.list (map choice choices) of
          E.Error (Left msg) -> E.Error $ Left msg
          E.Error (Right choices) -> E.Error $ Right (T e choices)
