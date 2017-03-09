SNAiL
=====
*Simple linear algebra library in nim*

Example
-------

Solving a linear system with gauss' method with partial pivoting looks like this:
``` nim
import snail

var A = matrix([[2.0,0],[0.0,3]])
var b = colVec([1.0,1])

proc `\`[N:static[int]](m:Matrix[N,N],v:Vector[N]):Vector[N] = ppge(m,v) # Cosmetic, just to match matlab syntax

let x = A\b
echo x

#> [+0.50|
#> |+0.33]
```

Compile with `nim c -r -d:release test.nim` or `nim c -r -d:openblas test.nim` ( be sure to have openblas installed ).
Bonus: `nim js -d:release test.nim` should work too!

Documentation
-------------

Nim-generated docs [here](http://stisa.space/snail)

Nimble tasks
--------------
If you have nimble and nim installed, run `nimble <taskname>` in the dir with `snail.nimble` to exec the corresponding task.

- `nimble tests`: runs the tests from  [/tests](tests).
- `nimble jstests`: builds the tests from [/tests](tests). It also generates a `index.html`file that runs all tests.
- `nimble docs`: generates the docs in [/docs](docs) using `nim docs2`.

Future structure
-----------------
*as in, plans*

- ~~for matrix and vector, have a single file (each) implementing basic operations ( sum, multiplication, norms, etc )~~
- a file for linear systems ( ~~GE, PPGE,~~ hopefully LU/LUP, QR,etc in the future )
- a file for eigenvalues/eigenvectors ( Jacobi, Gauss-Siedel...)
- a file for interpolations ( lagrange polynomial, Chebychev points, Lobatto points, linear interpolation, least squares)
- a file for beziér curves, b-splines, splines ( cubic? ), De Casteljau, control polygon
- a file for numeric integration ( simpson ( and composite ) , trapezoidal... )
- a file for estimating derivatives?

Other?? Linear regressions, finite differences...?


On Perfomance of a naive algebra library
----------------------------------------

No particular optimization has been done yet, and it is my intention to increase the performance of the nim implementation.
As a rough estimate, with `-d:openblas` multiplying two 100x100 matrices 100 times takes ~0.05s, while the nim implementation  
with `-d:release` takes ~0.3s , so around a 7x difference. 

If you need something more complete and are fine with configuring external libraries etc. ( and don't need js support ) consider using [linalg](https://github.com/unicredit/linear-algebra).

Misc notes
----------
- ~~Needs to be compiled with "--threads:on", TODO: fallback for when not threaded ( plus a warning? )~~
- **Needs more tests**
- ~~Flesh out arrayutils~~
- ~~Check arrayutils.zip and improve different size array handling ( eg zip(N,M) where M<N or generally M!=N ) ~~
- ~~change name to SNAil? Simple Nim Algebra..i.. lib~~
- ~~rework the structure to remove `include`s~~
- **test everything**
- try a more functional approach for concatenation of operations?
- use blas when avaliable/useful
