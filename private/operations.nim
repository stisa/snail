import sequtils
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
proc dot *[N:static[int]] (v: Vector[N], w: Vector[N]): float64 =
    result = zip(v.data,w.data)
        .map(proc(s:tuple[a:float,b:float]):float64 = s.a*s.b)
        .foldl(a+b)
# shorthand to^^
proc `*` *[N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= dot(v,w)

# Sum two vectors
proc add *[N:static[int]] (v: Vector[N], w: Vector[N]): Vector[N] = 
    new result.data
    result.data[0..N-1] = zip(v.data,w.data)
        .map(proc(s:tuple[a:float,b:float]):float64 = s.a+s.b) [0..N-1]
# shorthand to^^
proc `+` *[N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= add(v,w)


proc `*.` *[N:static[int]] (a: float64,v: Vector[N]): Vector[N] =
    new result.data
    result.data[0..N-1] = v.data.mapIt(a*it)[0..N-1]

proc `/.` *[N:static[int]] (a: float64,v: Vector[N]): Vector[N] =
    assert( anyIt(v.data,it!=0.0) == true)
    new result.data
    result.data[0..N-1] = v.data.mapIt(a/it)[0..N-1]

import threadpool

proc innDot [N,M,V:static[int]](m: Matrix[N,M], w: Matrix[M,V],res: var Matrix[N,V], r:int)=
    for c in 0..V-1: # on cols of w
    #result.data[r * M + c] = spawn innDot(m,w,r,c)
        res[r,c] = row(m,r)*col(w,c)
        #return   

{.experimental.}
proc matMul* [N,M,V:static[int]](m: Matrix[N,M], w: Matrix[M,V]) :Matrix[N,V] =
    new result.data
    parallel:
        for r in 0..N-1: # iter on rows of m
            spawn innDot(m,w,result,r)
        #e99*90+99
proc `*`* [N,M,V:static[int]](m: Matrix[N,M],
    w: Matrix[M,V]) :Matrix[N,V] {.inline.} = matMul(m,w)

proc matMulNP* [N,M,V:static[int]](m: Matrix[N,M], w: Matrix[M,V]) :Matrix[N,V] =
    for r in 0..N-1: # iter on rows of m
        for c in 0..V-1: # on cols of w
            result[r,c] = m.row(r)*w.col(c)   
 