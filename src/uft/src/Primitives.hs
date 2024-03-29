module Primitives where

import qualified Data.Map as M

type Name = String

data Base = Base String Int deriving Show

data Primitive = SetsRegister Base
               | HasEffect Base
               deriving Show

-- we add more binary airthmetic operators here

binary = [ "+", "-", "*", "/", "<", ">", ">=", "<=", "cons", "=", "idiv"
         , "mod", "and", "or", "xor", "mkclosure"
         ]

unary = [ "boolean?", "null?", "number?", "pair?", "function?", "nil?"
        , "symbol?", "car", "cdr", "truth", "not", "hash"
        ]

sideEffecty   = [ "print", "printu", "println" ] -- arity 1
errory         = [ "error" ]  -- arity 1 never returns
halty          = [ "halt" ]
checky         = [ "check", "expect" ] -- arity 2: one is literal

base p = case p of
  SetsRegister b -> b
  HasEffect b -> b 

name p = case base p of (Base n _) -> n
arity p = case base p of (Base _ a) -> a

throwsError p = name p == "error" || name p == "halt" 

-- (* For SETS_REGISTER, the instruction takes the destination register
--    as the first operand, and the actual parameters as remaining operands.

--    For HAS_FFECT, the instruction has no destination register;
--    the operands are the arguments.
    
--    A SETS_REGISTER primitive _must not_ have a side effect,
--    because if one appears in an effectful context, it is discarded.
--  *)

add :: Int -> (Base -> Primitive) -> [Name] -> [Primitive] -> [Primitive]
add arity ty names prims =
  foldl (\prims name -> ty (Base name arity) : prims)
    prims names

primitives :: [Primitive]
primitives =
    ( add 2 SetsRegister binary
    . add 1 SetsRegister unary
    . add 1 HasEffect sideEffecty
    . add 1 HasEffect errory
    . add 2 HasEffect checky
    . add 0 HasEffect halty
    ) [  -- useful spot to add more effectful primitives
      HasEffect (Base ":=" 2),
      SetsRegister (Base "popen" 1),
      SetsRegister (Base "dload" 1),
      HasEffect (Base "gc" 0),
      checkAssert
      ]

primMap :: M.Map Name Primitive
primMap = foldr (\p m -> M.insert (name p) p m) M.empty primitives

exposedNames :: [Name]
exposedNames = map name primitives

find :: Name -> Maybe Primitive
find x = M.lookup x primMap

-- hese are the primitives that are used inside the compiler
cons         = SetsRegister (Base "cons" 2)
setglobal    = HasEffect (Base "setglobal" 2)
getglobal    = SetsRegister (Base "getglobal" 1)
check        = HasEffect (Base "check" 2) -- for converting check-expect to K-normal form
expect       = HasEffect (Base "expect" 2) -- for converting check-expect to K-normal form
checkAssert = HasEffect (Base "check-assert" 1)
loadliteral  = SetsRegister (Base "loadliteral" 1)
mkclosure    = SetsRegister (Base "mkclosure" 2)
setclslot    = HasEffect (Base "setclslot" 3)
getclslot    = SetsRegister (Base "getclslot" 2)
getblkslot = SetsRegister (Base "getblockslot" 2)
setblkslot = HasEffect (Base "setblockslot" 3)
err = HasEffect (Base "error" 1)