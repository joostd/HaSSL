-- Public-key Cryptography
--
-- see also 'Introduction to Algorithms'
-- jpdijk, dec 92

-- Some usefull algorithms

module RSA
	( Message, Key, KeySet
	, encrypt, decrypt, keySet
	) where

import NumUtils	-- euclid, modexp

--
-- RSA Public-key Cryptosystem
--

-- Some tydedefs

type Key = (Integer, Integer)
type KeySet = (Key, Key)

type Message = Integer

-- Generating keys

keySet :: Integer -> Integer -> (Key, Key)
keySet p q = (public_key, private_key)
  where
    -- (p, q) = (11, 29)	-- generate
    n = p * q
    -- compute euler's phi function at n
    phi_n = (p-1) * (q-1)
    -- select some e
    e = head [ n | n <- [2..], gcd n phi_n == 1]
    -- compute multiplicative inverse of e modulo phi(n)
    (_,x,_) = euclid e phi_n
    d = if x < 0 then x+phi_n else x
    public_key = (e, n)
    private_key = (d, n)

-- Crypto functions

encrypt :: Key -> Message -> Message
decrypt :: Key -> Message -> Message

encrypt (e,n) m = modexp n m e
decrypt (d,n) m = modexp n m d

-- too slow:
--encrypt (e,n) = (`mod` n) . (^e)
--decrypt (d,n) = (`mod` n) . (^d)
