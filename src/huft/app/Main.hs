module Main where
import System.Environment ( getArgs, getProgName )   
import Data.List
import Data.Text
import Data.String
import System.IO

import Languages as L -- cabal will take care of it

translationOf :: String -> Maybe (L.Language, L.Language)
translationOf spec =
    case split (=='-') (fromString spec) of 
        [from, to] -> case (L.find (unpack from), L.find (unpack to)) of
                        (Just f, Just t) -> Just (f, t)
                        _                -> Nothing
        _          -> Nothing

reportandExit :: Maybe (L.Language, L.Language) -> IO ()
reportandExit Nothing = putStrLn "invalid translation specification"
reportandExit _       = putStrLn "Valid translation specification"

main :: IO ()
main = do  
    progName <- getProgName
    args <- getArgs
    -- mapM putStrLn args
    case args of
        spec:infile:_ -> do
            reportandExit (translationOf spec)
        _ -> putStrLn ("Usage: "++progName++" inLang-outLang infile")