

### example of usage:
```
{-# LANGUAGE OverloadedStrings #-}
import Data.String.Format

main :: IO () 
main = do 
    let x = fromFormat $ "x{}x{}x{}" <-> format 10 <-> format 20 <-> format 1.1 <-> "xx{}yy{}" <-> "10" <-> "ahhha"
    print x 
```
this will give the output of:
```
"x10x20x1.1xx10yyahhha"
```