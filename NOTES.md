
TODO: 
- change name to SNAil? Small Nim Algebra..il
- rework the structure to remove `include`s
- test everything
- try a more functional approach for concatenation of operations?

Future structure
-----------------

On Perfomance of a naive algebra library
----------------------------------------

On an i7 4710 ( laptop ) this library requires about **3.5s** to multiply two dense matrices 200x200.
From this comes the name: Naive Algebra ( note that no particular optimization has been done yet, and it is my intention to bring the time down ).

For reference, the same operation using [linalg]() with [openblas]() takes about **0.004s**, so use that if you need something faster and are fine with
configuring external libraries etc. ( linalg also doesn't work on web, I think )

I *think* this has to do with memory access/deepCopy happening/assignments, but I will have to profile the library to find out.

Performance up to matrices 100x100 is reasonable at ~0.5s, and some testing shows a sublinear correlation between #elements and time

MatMul, Tentative Improvements
------------------------------
- parallel inner for loop -> **worse**, 4.5s vs 3.5. Probably caused by `parallel` deepCopying the `ref array` representing data

Misc notes
----------
- ~~Needs to be compiled with "--threads:on", TODO: fallback for when not threaded ( plus a warning? )~~

- Needs more tests
- Flesh out arrayutils
- Check arrayutils.zip and improve different size array handling ( eg zip(N,M) where M<N or generally M!=N ) 

