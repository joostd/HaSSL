module RSA129 where
import RSA	-- RSA encryption
import Util	-- group
import NumUtils	-- group

-- The original 1977 RSA-129 challenge

--
-- The Challenge: the following information was given
--

-- public exponent
e = 9007
-- modulus
r = 114381625757888867669235779976146612010218296721242362562561842935706935245733897830597123563958705058989075147599290026879543541
-- ciphertext
ciphertext = 96869613754622061477140922254355882905759991124574319874695120930816298225145708356931476622883989628013391990551829945157815154

--
-- The solution
--

-- It turns out that r's factorization is [p1,p2]
p1 = 3490529510847650949147849619903898133417764638493387843990820577
p2 = 32769132993266709549961988190834461413177642967992942539798288533

-- Derive the private exponent from p1, p2 and e:
d = if x < 0 then x+phi_r else x where
	-- compute euler's totient function at r
	phi_r = (p1-1) * (p2-1)
	-- compute multiplicative inverse of e modulo phi(r)
	(_,x,_) = euclid e phi_r
-- d == 106698614368578024442868771328920154780709906633937862801226224496631063125911774470873340168597462306553968544513277109053606095

-- So, these are our keys:
private_key = (d,r)
public_key  = (e,r)

plaintext = decode . show . decrypt private_key $ ciphertext	-- Sapperdeflap!
challenge = encrypt public_key . read . encode $ plaintext

main = plaintext

--
-- The way texts are encoded
--

alphabet = [' '] ++ ['A'..'Z']

decode = map code . group 2 where
	code = (alphabet!!) . read

encode = concat . map code where
	code ' ' = "00"
	code  c  = padl '0' 2 . show $ ord c - ord '@'
