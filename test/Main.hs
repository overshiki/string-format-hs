{-# LANGUAGE OverloadedStrings #-}
module Main (main) where
import Data.String.Format


main :: IO () 
main = do 
    let x = fromFormat $ "x{}x{}x{}" <-> format 10 <-> format 20 <-> format 1.1 <-> "xx{}yy{}" <-> "10" <-> "ahhha"
    print x 
