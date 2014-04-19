HaSSL
=====

This is my 1992 teaching material on RSA that I retrieved from my archives more than 20 years later.
Some file were added in 2003.
The code was originally written for gofer, a Haskell-like language, and later ported to Haskell to run under Hugs98.

It struck me that after all this time, this code is stil usable for teaching purposes.

The original README file from 2003 is pasted verbatim below. I'm not sure if HaskellScript is still available somewhere.

README
======

This directory contains my Haskell RSA implementation, plus some demos.
You'll need a Haskell compiler or interpreter to run these programs.
You can download these for most platforms from http://www.haskell.org/.
If you want to use the browser interface, you'll need to download HaskellScript as well.
Note that HaskellScript is only available for Internet Explorer on MS Windows.

If you installed hugs, type

	$ hugs rsa-demo.hs
	and after the prompt ('RsaDemo>'), type 'main'

or

	$ hugs rsa-129.hs
	and after the prompt ('RSA129>'), type 'main'


Have Fun!
-- Joost van Dijk
-- joostd@liacs.nl

Files:
RSA.hs		- the RSA implementation
rsa-129.hs	- demo for decrypting Rivest's challenge from 1977
rsa-demo.hs	- wrapper for using RSA from the command line
rsa.html	- wrapper for using RSA from a browser with HaskellScript support
