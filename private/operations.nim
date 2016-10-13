#import types, arrayutils, sequtils

#import sequtils
# transpose in place. Should file a bug with nim: single ' not allowed as operator
# TODO: fix discard, this should be inlineable?
proc `t`* [N:static[int]] (v: var Vector[N]): Vector[N] =
    if v.isCol: v.isCol=false else: v.isCol=true

# transpose, copying. Should file a bug with nim: single ' not allowed as operator
proc `t`* [N:static[int]] (v: Vector[N]): Vector[N] =
    result = v
    if result.isCol: result.isCol=false else: result.isCol=true

# take the sum of the abs values of the elements of a vector v
proc l_1 *[N:static[int]] (v: Vector[N]): float64 =
    result = v.data.foldl(abs(a)+abs(b))

# Vector dot product
proc dot *[N:static[int]] (v: Vector[N], w: Vector[N]): float =
    result = zip(v.data,w.data).innerDotZipped
    #result = zip(v.data,w.data)
    #    .map(proc(s:tuple[a:float,b:float]):float64 = s.a*s.b)
    #    .foldl(a+b)
# shorthand to^^
proc `*` *[N:static[int]] (v: Vector[N], w: Vector[N]): float {.inline.}= dot(v,w)

# Sum two vectors
proc add *[N:static[int]] (v: Vector[N], w: Vector[N]): Vector[N] = 
    new result.data
    #echo "wtf"& $N
    let tmpseq = zip(v.data,w.data).map(proc(s:tuple[a:float,b:float]):float64 = s.a+s.b)
    #echo "wtf"& $tmpseq
    #echo "wtf"& $result.data
    for i,r in result.data[].mpairs :
        r = tmpseq[i] 
        #echo i
    #echo result.data
# shorthand to^^
proc `+` *[N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= add(v,w)


proc `*.` *[N:static[int]] (a: float64,v: Vector[N]): Vector[N] =
    new result.data
    result.data[0..N-1] = v.data.mapIt(a*it)[0..N-1]

proc `/.` *[N:static[int]] (a: float64,v: Vector[N]): Vector[N] =
    assert( anyIt(v.data,it!=0.0) == true)
    new result.data
    result.data[0..N-1] = v.data.mapIt(a/it)[0..N-1]

#[
import threadpool
proc innDot [N,M,V:static[int]](m: Matrix[N,M], w: Matrix[M,V],res: var Matrix[N,V], r:int)=
    for c in 0..V-1: # on cols of w
        res[r,c] = row(m,r)*col(w,c)
        #result.data[r * M + c] = spawn innDot(m,w,r,c) 

{.experimental.}
proc matMulP* [N,M,V:static[int]](m: Matrix[N,M], w: Matrix[M,V]) :Matrix[N,V] =
    new result.data
    parallel:
        for r in 0..N-1: # iter on rows of m
            spawn innDot(m,w,result,r)
        #e99*90+99
]#

proc matMul* [N,M,V:static[int]](m: Matrix[N,M], w: Matrix[M,V]) :Matrix[N,V] =
    new result.data
    for r in 0..N-1: # iter on rows of m
        for c in 0..V-1: # on cols of w
            result[r,c] = m.row(r)*w.col(c) 
proc `*`* [N,M,V:static[int]](m: Matrix[N,M],
    w: Matrix[M,V]) :Matrix[N,V] {.inline.} = matMul(m,w)

proc vecMatMul* [N,M:static[int]](m: Matrix[N,M], v: Vector[M]) :Vector[N] =
    new result.data
    assert(v.isCol == true)
    #echo result.data
    for r in 0..N-1: # iter on rows of m
     #   echo r
        result[r] = m.row(r)*v 
        #echo result.data
    result.isCol = true

proc `*`* [N,M:static[int]](m: Matrix[N,M],
    v: Vector[M]) :Vector[N] {.inline.} = vecMatMul(m,v)

# Sum two matrices. Restricted to congruent dimensions.
proc addM *[N,M:static[int]] (m: Matrix[N,M], w: Matrix[N,M]): Matrix[N,M] = 
    new result.data
    result.data[0..(N*M)-1] = zip(m.data,w.data)
        .map(proc(s:tuple[a:float,b:float]):float64 = s.a+s.b) [0..(N*M)-1]
# shorthand to^^
proc `+` *[N,M:static[int]] (m: Matrix[N,M], w: Matrix[N,M]): Matrix[N,M]{.inline.}= addM(m,w)

#proc gauss*[N,M:static[int]](A:Matrix[N,M],b:Vector[M]):Vector[N] =
#    discard 

#proc solve*[N,M:static[int]](A:Matrix[N,M],b:Vector[M]):Vector[N] {.inline.} = solve(A,b)

