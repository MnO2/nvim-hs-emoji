{-# LANGUAGE ScopedTypeVariables #-}
module Fibonacci.Plugin (fibonacci, emojicomplete) where

import Neovim
import Data.List as L
import Data.Maybe (fromMaybe)

fibonacci :: Neovim r st String
fibonacci = do 
  cw <- errOnInvalidResult $ vim_call_function "expand" $ [toObject "<cword>"]
  let n = read cw
  return $ show (fibs !! n)
  where
    fibs :: [Integer]
    fibs = 0:1:scanl1 (+) fibs


emojicomplete :: Bool -> String -> Neovim r st (Either Int [String])
emojicomplete findstart base = do
  if findstart
     then do 
       curr_line :: String <- errOnInvalidResult $ vim_call_function "getline" $ [toObject "."]
       curr_col :: Int <- errOnInvalidResult $ vim_call_function "col" $ [toObject "."]
       let prefix = take (curr_col-1) curr_line
       let reverse_idx = fromMaybe 0 (L.findIndex (== ' ') (reverse prefix))
       return $ Left (curr_col - reverse_idx - 1) 
     else do
       let emoji = [":thumbsup:", ":thumbsdown:", ":smile:", ":banana:"] 
       let ans = filter (L.isPrefixOf base) emoji
       return $ Right ans 
