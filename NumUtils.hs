module NumUtils
	( primes, isPrime, isPseudoPrime, findPrime, euclid, modexp
	) where

-- Prime numbers

primes :: [Integer]
primes = sieve [2..]
  where
    sieve (n:ns) = n : sieve (filter (\d -> d `mod` n /= 0) ns)

isPrime p = all (\n -> p `mod` n /= 0) [ 2.. (floor.sqrt.fromInteger $ p) ]	-- very inefficient!

isPseudoPrime p = modexp p 2 (p-1) == 1						-- less accurate, but much more efficient

findPrime start = head ( filter isPseudoPrime [ start.. ] )
findPrime start = head ( filter isPrime [ start.. ] )		-- not used

--
-- Extended Euclid Algorithm
--

--   euclid a b == (d,x,y)  <=>  d == gcd a b && x*a + y*b = d

euclid a 0 = (a,1,0)
euclid a b = (d,y,x-q*y)
 where
  (d,x,y) = euclid b r
  (q,r) = quotRem a b

--
-- Modular Exponentiation
--

-- this is a lot faster then first exponentiating and then dividing
-- for large integers

modexp k x 0 = 1
modexp k x n
  | n > 0 = f k x (n-1) x
  where
    f k _ 0 y = y
    f k x n y = g k x n
     where
      g k x n
        | even n    = g k ((x*x) `mod` k) (n`quot`2)
	| otherwise = f k x (n-1) ((x*y) `mod` k)
modexp _ _ _ = error "modexp: negative exponent"
