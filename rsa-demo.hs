-- Public-key Cryptography
--
-- Example

module RsaDemo where
import RSA

getKeys =
 do putStr "Enter first prime base: "
    s1 <- getLine
    let i1 = read s1
    putStr "Enter second prime base: "
    s2 <- getLine
    let i2 = read s2
    let (p,q) = (findPrime i1, findPrime i2)
    if (not $ isPrime i1) then putStrLn $ show i1 ++ " is not prime, using " ++ show p ++ " instead" else return ()
    if (not $ isPrime i2) then putStrLn $ show i2 ++ " is not prime, using " ++ show q ++ " instead" else return ()
    p <- if( p==q ) then return (findPrime (p+1)) else return p
    if (i1==i2) then putStrLn $ show i2 ++ " is already used, using " ++ show p ++ " instead" else return ()
    return (keySet p q)

getMessage modulus =
 do putStr $ "Enter message: "
    message <- getLine
    --putStrLn $ "message in base 256: " ++ (show $ map ord message)
    let chunk = undigits 256 (map (toInteger.ord) message)	-- render msg as one huge number
    --putStrLn $ "message as huge number: " ++ (show chunk)
    let chunks = digits modulus chunk	-- split huge number into digestable chunks
    --putStrLn $ "message in base " ++ show modulus ++ ": " ++ (show chunks)
    return (map toInteger chunks)

main =
 do putStrLn "Generating keys..."
    (public_key, private_key) <- getKeys
    putStrLn $ "Public key is " ++ show public_key
    let modulus = (snd public_key)
    plaintext <- getMessage modulus
    putStrLn $ "message is: " ++ (show plaintext)
    -- Plaintext Encryption --
    putStrLn "Encrypting..."
    let ciphertext = map (encrypt public_key) plaintext
    putStrLn (show ciphertext)
    -- Ciphertext Decryption --
    putStrLn "Decrypting..."
    let message = map (decrypt private_key) ciphertext
    putStrLn (show message)
    let s = map (chr.toInt) . digits 256 . undigits modulus $ message
    putStrLn (show s)

--
-- Radix conversion
--

-- convert a list in radix r to a number and vice versa
digits radix 0 = []
digits radix n = digits radix (q) ++ [r] where
	(q,r) = n `quotRem` radix
undigits radix = foldl (\n digit -> radix*n + digit) 0
