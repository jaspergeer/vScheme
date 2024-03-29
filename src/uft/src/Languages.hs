module Languages where
import qualified Data.Map as M

data Language = ES | HOX | HO | FO | CL | KN | VS | VO deriving (Enum, Eq, Show)
instance Ord Language where
  a <= b = fromEnum a <= fromEnum b

tableInit = 
  [ (ES,  "es",  "eScheme (ho vScheme plus Erlang-style pattern matching)")
  , (HOX, "hox", "Higher-order vScheme with mutable variables in closures")
  , (HO,  "ho",  "Higher-order vScheme")
  , (FO,  "fo",  "First-order vScheme")
  , (CL,  "cl",  "First-order vScheme with closure and capture forms")
  , (KN,  "kn",  "K-Normal form")
  , (VS,  "vs",  "VM assembly language")
  , (VO,  "vo",  "VM object code")
  , (ES, "", "") ]

table :: M.Map Language (String, String)
table = foldr (\(x, y, z) m -> M.insert x (y, z) m)  M.empty tableInit

shortTable :: M.Map String Language
shortTable = foldr (\(x, y, _) m -> M.insert y x m)  M.empty tableInit

pred :: Language -> Maybe Language
pred HOX = Nothing
pred ES  = Nothing
pred l   = Just $ Prelude.pred l

find :: String -> Maybe Language
find x = M.lookup x shortTable

description :: (String, String) -> String
description (_, d) = d
