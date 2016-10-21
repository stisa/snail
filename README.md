SNAiL
=====
*Simple linear algebra library in nim*

Example
-------

Solving a linear system with gauss' method with partial pivoting looks like this:
``` nim
import snail/matrix, snail/vector # So we can use matrices and vectors
from snail/linsys import ppge

var A = matrix([[2.0,0],[0.0,3]])
var b = colVec([1.0,1])

proc `\`[N:static[int]](m:Matrix[N,N],v:Vector[N]):Vector[N] = ppge(m,v) # No reason, just so we can match matlab syntax

let x = A\b
echo x

# [+0.50|
# |+0.33]
```

Documentation
-------------

Nim-generated docs [here](http://stisa.space/snail)

Future structure
-----------------

- ~~for matrix and vector, have a single file (each) implementing basic operations ( sum, multiplication, norms, etc )~~
- a file for linear systems ( GE, PPGE, hopefully LU/LUP, QR,etc in the future )
- a file for eigenvalues/eigenvectors ( Jacobi, Gauss-Siedel...)
- a file for interpolations ( lagrange polynomial, Chebychev points, Lobatto points, linear interpolation, least squares)
- a file for beziér curves, b-splines, splines ( cubic? ), De Casteljau, control polygon
- a file for numeric integration ( simpson ( and composite ) , trapezoidal... )
- a file for estimating derivatives?

Other?? Linear regressions, finite differences...?


On Perfomance of a naive algebra library
----------------------------------------

On an i7 4710 ( laptop ) this library requires about **3.5s** to multiply two dense matrices 200x200.
Note that no particular optimization has been done yet, and it is my intention to bring the time down.

For reference, the same operation using [linalg](https://github.com/unicredit/linear-algebra) takes about **0.004s**, so use that if you need something faster and are fine with
configuring external libraries etc. ( linalg also doesn't work on web, I think )

Misc notes
----------
- ~~Needs to be compiled with "--threads:on", TODO: fallback for when not threaded ( plus a warning? )~~

- Needs more tests
- Flesh out arrayutils
- Check arrayutils.zip and improve different size array handling ( eg zip(N,M) where M<N or generally M!=N ) 
- change name to SNAil? Simple Nim Algebra..i.. lib
- rework the structure to remove `include`s
- test everything
- try a more functional approach for concatenation of operations?
