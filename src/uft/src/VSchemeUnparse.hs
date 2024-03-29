module VSchemeUnparse where
import Prelude hiding ( exp )
import qualified VScheme as S
import qualified Prettyprinter as P
import qualified Case
import qualified Pattern as Pat
-- sadly HLS cannot go any farther, cabal repl and :t is the move now
-- see https://hackage.haskell.org/package/prettyprinter-1.7.1/docs/Prettyprinter.html#v:pretty

(<+>) = (P.<+>)
-- using `te = P.pretty` is not working

letkeyword S.Let = P.pretty "let "
letkeyword S.LetRec = P.pretty "letrec"

value (S.Sym s) = P.pretty s
value (S.Int i) = P.pretty i
value (S.Real n) = P.pretty n
value (S.Bool b) = P.pretty(if b then "#t" else "#f")
value S.EmptyList = P.pretty"()"
-- not sure, nr defened group, and seq
value (S.Pair car cdr) = 
    P.group $ P.parens $ P.vsep $ values (S.Pair car cdr)
    where
        values S.EmptyList = []
        values (S.Pair car cdr) = value car : values cdr
        values v = [P.pretty"." <+> value v]

--   fun kw k docs = P.group (te "(" ++ te k ++ te " " ++ P.seq cn id docs ++ te ")")

kw k docs = P.group $ P.parens $ P.pretty k <+> P.vsep docs

wrap = P.group . P.parens . P.vsep
wraps = P.group . P.brackets . P.vsep

-- nestedBindings (prefix', S.LetX (S.Let, [(x, e')], e)) = nestedBindings ((x, e') :: prefix', e)
-- nestedBindings (prefix', e) = (rev prefix', e)

-- NEED TO DO LETX RESURGARING AT SOME POINT

pat (Pat.Var x) = P.pretty x
pat Pat.Wildcard = P.pretty "_"
pat (Pat.Apply vcon []) = P.pretty vcon
pat (Pat.Apply vcon ps) = P.nest 3 (wrap (P.pretty vcon : map pat ps))


exp (S.Literal v) = case v of
        S.Int _ -> value v
        S.Real _ -> value v
        S.Bool _ -> value v 
        _ -> P.pretty "'" <> value v  
        -- why tik before these value, not shown in intepreter of vschme -vv
exp (S.Var s) = P.pretty s
exp (S.Set x e) = P.nest 3 $ kw "set" [P.pretty x, exp e]
exp (S.IfX e1 e2 e3) = P.nest 3 $ kw "if" [exp e1, exp e2, exp e3]
exp (S.WhileX e1 e2) = P.nest 3 $ kw "while" [exp e1, exp e2]
exp (S.Begin es) = P.group $ P.nest 3 $ P.parens $ P.pretty"begin" <+> P.vsep (map exp es)
exp (S.Apply (S.VCon k) []) = P.pretty k
exp (S.Apply e es) = P.nest 3 $ wrap (exp e : map exp es)
-- not sure how to use this
-- exp (S.LetX S.LET [(x, e')], e)
exp (S.LetX lk bs e) = case lk of
    S.Let -> P.nest 3 $ pplet "let" bindings (exp e)
    S.LetRec -> P.nest 3 $ pplet "letrec" bindings (exp e)
    where
        pplet k bs e = P.parens $ P.pretty k <+> (P.parens $ P.align (P.vsep bs)) <> P.line <> e
        bindings = [P.pretty "[" <> P.pretty x <+> exp e <> P.pretty "]" | (x, e) <- bs]
-- ignore other letkinds because i dont quite get what wppscheme is trying to do
exp (S.Lambda xs body) = P.nest 3 $ kw "lambda" [wrap (map P.pretty xs), exp body]
-- module 12 case expressions
exp (S.Case (Case.T e choices)) = 
    let choice (p, e) = P.nest 6 (wraps [pat p, exp e])
    in P.nest 3 (kw "case" [exp e, P.vsep $ map choice choices])
exp (S.VCon "'()") = P.pretty "'()"
exp (S.VCon k) = P.pretty $ "'" <> k -- append
exp (S.Cond qas) =
    let qa (q, a) = P.nest 6 (wraps [exp q, exp a])
     in P.nest 3 (kw "cond" [on, P.vsep $ map qa qas])
    where
        on = P.pretty " "
--   val on = te " " ++ P.Line.optional

def d = case d of
    (S.Val x e) -> P.nest 3 $ kw "val" [P.pretty x, exp e]
    (S.Define f xs e) -> P.nest 3 $ kw "define" [P.pretty f, wrap (map P.pretty xs), exp e]
    (S.CheckExpect e1 e2) -> P.nest 3 $ kw "check-expect" [exp e1, exp e2]
    (S.CheckAssert e) -> P.nest 3 $ kw "check-assert" [exp e]
    (S.Exp e) -> exp e

pp = show . def
ppexp = show . exp

-- need to strip final new line?

-- expString = show . ppexp

-- needa figure out where let* comes from

--  test for let beding
-- VU.exp (V.LetX V.Let [("x", (V.Literal (V.Int 1))), ("y", (V.Literal (V.Int 1))) ] (V.Literal (V.Int 1)))
