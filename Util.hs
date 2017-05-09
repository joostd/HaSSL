module Util
        ( group
        , join
        , padl, padr
        ) where

-- join a list using s as a separator
join s = foldr1 (\x xs -> x++s++xs)

-- group a list in portions of length n
group n xs = takeWhile (not.null) $ take n xs : group n (drop n xs)

-- padding left and right with element e to a total of n elements
padr e n xs = xs ++ replicate (n - length xs) e
padl e n xs = replicate (n - length xs) e ++ xs

