from strutils import formatFloat,FloatFormatMode

when defined openblas:
  import nimblas

const Epsilon = 1.0e-6

type 
    RowVector* [N:static[int]] = object
      ## A row vector 
      ## 
      ## Example:
      ## [1.0, 2.0, 3.0]
      data*:ref array[N, float]
      when not defined(js):p*: ptr float
 
    ColVector* [N:static[int]] = object
      ## A column vector 
      ## 
      ## Example:
      ## |    [1.0\| 
      ## |    \|2.0\|
      ## |    \|3.0]
      data*:ref array[N, float]
      when not defined(js):p*: ptr float

    Vector* [N:static[int]]= RowVector[N] | ColVector[N]
      ## A generic vector

    Array[N: static[int]] = array[N, float64] # hackhis, gives nicer code tho

proc rowVec*  [N:static[int]](arr: Array[N]): RowVector[N] =
  ## Create a new row vector, takes an array of floats
  new result.data
  result.data[] = arr
  when not defined js: result.p = addr result.data[0]

proc colVec*  [N:static[int]](arr: Array[N]): ColVector[N] =
  ## Create a new row vector, takes an array of floats
  new result.data
  result.data[] = arr
  when not defined js: result.p = addr result.data[0]

proc toRow* [N:static[int]](arr: Array[N]): RowVector[N] {.inline.} = arr.rowVec 
  ## Create a new row vector, takes an array of floats
  
proc toCol* [N:static[int]](arr: Array[N]): ColVector[N] {.inline.} = arr.colVec
  ## Create a new row vector, takes an array of floats
  
#[ Future ]
proc randomVec* (N: static[int],max: float = 1): Vector[N] =  
  new result.data
  for i in mitems(result.data[]): i = random(max)
]#

proc len*[N: static[int]](v: Vector[N]): int = N
  ## The length of the vector. Read only.

proc `[]`*[N : static[int]](v: Vector[N], i:int): float {.inline.} = v.data[i]

proc `[]=`*[N : static[int]](v: Vector[N], i:int, val: float) {.inline.} = v.data[i] = val 

proc eq*[N : static[int]](v,w: Vector[N],epsilon:float=Epsilon):bool =
  ## Equal up to epsilon
  let wdata = w.data[]
  for i,e in pairs(v.data[]):
    if abs(e - wdata[i])>epsilon: return false
  result = true

proc `==`*[N : static[int]](v,w: Vector[N],epsilon=Epsilon):bool {.inline.} =
  eq(v,w,epsilon)

proc `===`*[N : static[int]](v,w: Vector[N]):bool =
  ## Exact equality.
  for i,e in pairs(v.data[]):
    if e != w.data[][i]: return false
  result = true

proc `$`*[N:static[int]] (v: ColVector[N]): string =
    result = "["
    if isNil(v.data): result.add("nil]\n")
    else:
      for i,e in v.data[]:
        let fstring = if e>=0: '+'&formatFloat(e,ffDecimal,2) 
                        else: formatFloat(e,ffDecimal,2)
        if(i==N-1): result.add(fstring&"]")
        else:
          result.add( fstring & "|\n|")
    
proc `$`*[N:static[int]] (v: RowVector[N]): string =
    result = "["
    if isNil(v.data): result.add("nil]\n")
    else:
      for i,e in v.data[]:
        let fstring = if e>=0: '+'&formatFloat(e,ffDecimal,2) 
                        else: formatFloat(e,ffDecimal,2)
        if(i==N-1): result.add(fstring&"]")
        else:
          result.add(fstring & ", ")

import math

proc low*(v: ColVector):int = v.data[].low # TODO
proc high*(v: ColVector):int = v.data[].high 
proc low*(v: RowVector):int = v.data[].low # TODO
proc high*(v: RowVector):int = v.data[].high

proc `t`* [N:static[int]] (v: ColVector[N]):RowVector[N] = rowVec(v.data[])
  ## Transpose the vector ( col -> row )
proc `t`* [N:static[int]] (v: RowVector[N]):ColVector[N] = colVec(v.data[])
  ## Transpose the vector ( row -> col )
proc pnorm *[N:static[int]] (v: Vector[N],p:Natural=1): float =
  ## P norm: \|v\| = p-root(sum ( \|x_i\|^p) )
  assert(p>=1)
  for i in v.low..v.high:
    result += abs(v[i]).pow(p.float)
  result = result.pow(1/p)

proc enorm *[N:static[int]] (v: Vector[N]): float =
  ## Euclidean norm: \|v\| = sqrt(sum ( \|x_i\|^2) )
  when declared(nimblas):
    return nimblas.nrm2(N, v.p, 1)
  else:
    pnorm(v,2)

proc norm *[N:static[int]] (v: Vector[N]): float =
  ## Infinite norm: \|v\| = max_i of \|x_i\| 
  for p in v.low..v.high:
    if abs(v[p])>result: result = abs(v[p])

proc dot *[N:static[int]] (v, w: Vector[N]): float =
  ## Vector dot product. Can use openblas.  
  when declared(nimblas):
    return nimblas.dot( N, v.p, 1, w.p,  1)
  else:
    for i in v.low..v.high:
      result += v[i]*w[i]

proc dot *[N:static[int]] (v:RowVector[N], w: ColVector[N]): float =
  ## Vector dot product. Can use openblas.
  when declared(nimblas):
    return nimblas.dot(N, v.p, 1, w.p, 1)
  else:
    for i in vector.low(v)..vector.high(v):
      result += v[i]*w[i]

proc `*` *[N:static[int]] (v, w: Vector[N]): float {.inline.}= dot(v,w)
  ## shorthand for `dot`
proc `*` *[N:static[int]] (v:RowVector[N], w: ColVector[N]): float = dot(v,w)
  ## shorthand for `dot`

proc add *[N:static[int]] (v, w: Vector[N]): Vector[N] =
  # Sum two vectors. Can use openblas
  new result.data
  when not defined js: result.p = addr result.data[0]
  when declared(nimblas):
    nimblas.copy(N,v.p,1,result.p,1)
    nimblas.axpy(N,1,result.p,1,w.p,1)
  else:
    for i in v.low..v.high:
      result[i] = v[i]+w[i]

proc `+` *[N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= add(v,w)
  ## shorthand to add

proc sub *[N:static[int]] (v, w: Vector[N]): Vector[N] =
  ## Subtract two vectors.
  new result.data
  when not defined js: result.p = addr result.data[0]
  for i in v.low..v.high:
    result[i] = v[i]-w[i]

proc `-` *[N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= sub(v,w)
  ## shorthand to `sub`

proc `*` *[N:static[int]] (a: float64,v: Vector[N]): Vector[N] =
  ## scalar times vector. Can use openblas
  new result.data
  when not defined js: result.p = addr result.data[0]
  when declared(nimblas):
    nimblas.copy(N,v.p,1,result.p,1)
    nimblas.scal(N, a, result.p, 1)
  else:
    for i in v.low..v.high:
      result[i] = a*v[i]

proc `.*` *[N:static[int]] (v,w: Vector[N]): Vector[N] =
    ## Elementwise vector product. 
    new result.data
    when not defined js: result.p = addr result.data[0]
    for i in v.low..v.high:
      result[i] = v[i]*w[i]


proc `/`* [N:static[int]](v: Vector[N],val:float): Vector[N] =
  ## Vector divided by val
  assert(val!=0.0, "Div by zero")
  new result.data
  when not defined js: result.p = addr result.data[0]
  for i in v.low..v.high:
    result.data[i] = v.data[i]/val

proc `./`* [N:static[int]](v,w: Vector[N]): Vector[N] =
  ## Vector elementwise division
  new result.data
  when not defined js: result.p = addr result.data[0]
  for i in v.low..v.high:
    assert(w[i]!=0.0, "Division by zero")
    result[i] = v[i]/w[i]

proc rowones*(N:static[int]):RowVector[N] =
  ## Construct a vector of N 1s
  new result.data
  when not defined js: result.p = addr result.data[0]
  for v in result.data[].mitems:
    v = 1.0

proc rowzeros*(N:static[int]):RowVector[N] =
  ## Construct a vector of N 0s
  new result.data
  when not defined js: result.p = addr result.data[0]

iterator items*[N:static[int]](a: Vector[N]): float {.inline.} =
  ## iterates over each item of `a`.
  var i = low(a)
  if i <= high(a):
    while true:
      yield a[i]
      if i >= high(a): break
      inc(i)

iterator mitems*[N:static[int]](a: var Vector[N]): var float {.inline.} =
  ## iterates over each item of `a`, yielding a mutable value
  var i = low(a)
  if i <= high(a):
    while true:
      yield a.data[i]
      if i >= high(a): break
      inc(i)

iterator pairs*[N:static[int]](a: Vector[N]): tuple[key: int, val: float] {.inline.} =
  ## iterates over each item of `a`. Yields ``(index, a[index])`` pairs.
  var i = low(a)
  if i <= high(a):
    while true:
      yield (i, a[i])
      if i >= high(a): break
      inc(i)

iterator mpairs*[N:static[int]](a: var Vector[N]): tuple[key:int,val:var float] {.inline.} =
  ## iterates over each item of `a`. Yields ``(index, a[index])`` pairs.
  ## ``a[index]`` can be modified.
  var i = low(a)
  if i <= high(a):
    while true:
      yield (i, a.data[i])
      if i >= high(a): break
      inc(i)