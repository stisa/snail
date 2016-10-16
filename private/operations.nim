#import types, arrayutils, sequtils
import math
#import sequtils
# transpose in place. Should file a bug with nim: single ' not allowed as operator
# TODO: fix discard, this should be inlineable?
proc `t`* [N:static[int]] (v: var Vector[N]): Vector[N] =
    if v.isCol: v.isCol=false else: v.isCol=true

# transpose, copying. Should file a bug with nim: single ' not allowed as operator
proc `t`* [N:static[int]] (v: Vector[N]): Vector[N] =
    result = v
    if result.isCol: result.isCol=false else: result.isCol=true

# P-norm
proc pnorm *[N:static[int]] (v: Vector[N],p:range[1..high(int)]=1): float =
  for i in 0..<v.len:
    result += abs(v[i]).pow(p.float)
  result = result.pow(1/p)

# Euclidean norm
proc enorm *[N:static[int]] (v: Vector[N]): float = pnorm(v,2)

# Infinite norm
proc norm *[N:static[int]] (v: Vector[N]): float = 
  for p in 0..<N: 
    if abs(v[p])>result: result = abs(v[p])


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
    let tmpseq = zip(v.data,w.data).map(proc(s:tuple[a:float,b:float]):float64 = s.a+s.b)
    for i,r in result.data[].mpairs :
        r = tmpseq[i] 

# shorthand to^^
proc `+` *[N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= add(v,w)

proc sub *[N:static[int]] (v: Vector[N], w: Vector[N]): Vector[N] = 
    new result.data
    let tmpseq = zip(v.data,w.data).map(proc(s:tuple[a:float,b:float]):float64 = s.a-s.b)
    for i,r in result.data[].mpairs :
        r = tmpseq[i] 

# shorthand to^^
proc `-` *[N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= sub(v,w)


proc `*` *[N:static[int]] (a: float64,v: Vector[N]): Vector[N] =
    new result.data
    for i in 0..<N:
      result.data[i] = a*v.data[i]
    #result.data[0..N-1] = v.data.mapIt(a*it)[0..N-1]

proc `.*` *[N:static[int]] (v,w: Vector[N]): Vector[N] =
    new result.data
    for i in 0..<N:
      result.data[i] = v.data[i]*w.data[i]


proc `/.` *[N:static[int]] (a: float64,v: Vector[N]): Vector[N] =
    assert( anyIt(v.data,it!=0.0) == true)
    new result.data
    result.data[0..N-1] = v.data.mapIt(a/it)[0..N-1]

proc `./=`* [N:static[int]](v:var Vector[N],val:float) = 
  assert(val!=0.0, "Div by zero")
  for e in v.mitems: e/=val

proc `./`* [N:static[int]](v: Vector[N],val:float): Vector[N] =
  assert(val!=0.0, "Div by zero")
  new result.data
  for i in 0..<N:
    result.data[i] = v.data[i]/val

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
        .map(proc(s:tuple[a:float,b:float]):float64 = s.a+s.b)[0..(N*M)-1]
# shorthand to^^
proc `+` *[N,M:static[int]] (m: Matrix[N,M], w: Matrix[N,M]): Matrix[N,M]{.inline.}= addM(m,w)

proc subtractVecFromRow* [N:static[int]](A:var Matrix[N,N],row:int,vec:Vector[N],times:float=1.0)=
 # echo "fm>",A.row(row)
 # echo "wht>",vec
  for j in 0..<N: A[row,j] = A[row,j]-A[row,j]*times*vec[j]

proc divRowByFloat* [N:static[int]](A:var Matrix[N,N],row:int,val:float)=
  for j in 0..<N: A[row,j] = A[row,j]/val

proc norm*[N,M:static[int]] (m: Matrix[N,M]): float =
  for i in 0..<N:
    var tmp = 0.0
    for j in 0..<M:
      tmp += abs(m[i,j])
    echo tmp
    if tmp>result: result = tmp
  