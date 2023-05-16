{-# LANGUAGE OverloadedStrings #-}

{-|
Module      : W
Description : a simple string formatting function 
Copyright   : (c) Le Niu, 2023
License     : MIT
Maintainer  : le.niu@hotmail.com
Stability   : experimental
Portability : portable

a simple string formatting function works in the similar way to python's ("{}".format(x))

More specifically:

>>> "10 {} {} = " <-> format "-" <-> format 2.0 <-> format 8.0

will result in 

>>> Format "10 - 2.0 = 8.0"

and you can use fromFormat to extract the wrapped string from it

>>> fromFormat $ Format "10 - 2.0 = 8.0"

As you can see, \<-\> operator is used to chain multiple Format type of data. And "{}" works as a hole, which means the subsequent Format type of data will be used to fill the hole. If there are no holes to be filled, then the string will be simply concatenated at the end.

Note that OverloadedStrings extention is needed to declare a Format type of data without Format constructor
-}
module Data.String.Format (Format(..), (<->), format, fromFormat) where 
import Data.String

data Format = Format String deriving (Show, Eq)

instance IsString Format where
    fromString = Format

instance Semigroup Format where 
    (<>) (Format (x:y:xs)) (Format t)
            | x=='{' && y=='}' = Format (t ++ xs)
            | otherwise        = (Format [x]) <+> ((Format (y:xs)) <> (Format t))
            where 
                (<+>) (Format _x) (Format _y) = Format (_x ++ _y)

    (<>) (Format [x]) (Format t) = Format ([x] ++ t)
    (<>) (Format []) t  = t

format :: (Show a) => a -> Format
format = Format . show

fromFormat :: Format -> String 
fromFormat (Format x) = x

infixl 1 <->
(<->) :: Format -> Format -> Format
(<->) = (<>)