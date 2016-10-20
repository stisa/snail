from strutils import formatFloat,FloatFormatMode

type 
    RowVector* [N:static[int]] = object
      ## A row vector 
      ## 
      ## Example:
      ## [1.0, 2.0, 3.0]
      data*:ref array[N, float]
    
    ColVector* [N:static[int]] = object
      ## A column vector 
      ## 
      ## Example:
      ## |    [1.0\| 
      ## |    \|2.0\|
      ## |    \|3.0]
      data*:ref array[N, float]
    
    Vector* [N:static[int]]= RowVector[N] | ColVector[N]
      ## A generic vector

    Array[N: static[int]] = array[N, float64] # hackhis, gives nicer code tho

proc rowVec*  [N:static[int]](arr: Array[N]): RowVector[N] =
  ## Create a new row vector, takes an array of floats
  new result.data
  result.data[] = arr

proc colVec*  [N:static[int]](arr: Array[N]): ColVector[N] =
  ## Create a new row vector, takes an array of floats
  new result.data
  result.data[] = arr

#[ Future ]
proc randomVec* (N: static[int],max: float = 1): Vector[N] =  
  new result.data
  for i in mitems(result.data[]): i = random(max)
]#

proc len*[N: static[int]](v: Vector[N]): int = N

proc `[]`*[N : static[int]](v: Vector[N], i:int): float {.inline.} = v.data[i]

proc `[]=`*[N : static[int]](v: Vector[N], i:int, val: float) {.inline.} = v.data[i] = val 

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
proc `t`* [N:static[int]] (v: RowVector[N]):ColVector[N] = colVec(v.data[])

proc pnorm *[N:static[int]] (v: Vector[N],p:Natural=1): float =
  assert(p>=1)
  ## P norm: \|v\| = p-root(sum ( \|x_i\|^p) )
  for i in v.low..v.high:
    result += abs(v[i]).pow(p.float)
  result = result.pow(1/p)

proc enorm *[N:static[int]] (v: Vector[N]): float = pnorm(v,2)
  ## Euclidean norm: \|v\| = sqrt(sum ( \|x_i\|^2) )

proc norm *[N:static[int]] (v: Vector[N]): float = 
  ## Infinite norm: \|v\| = max_i of \|x_i\| 
  for p in v.low..v.high: 
    if abs(v[p])>result: result = abs(v[p])

# Vector dot product
proc dot *[N:static[int]] (v, w: Vector[N]): float =
    for i in v.low..v.high:
      result += v[i]*w[i]
    return sqrt(result)

proc `*` *[N:static[int]] (v, w: Vector[N]): float {.inline.}= dot(v,w)

# Sum two vectors
proc add *[N:static[int]] (v, w: Vector[N]): Vector[N] = 
    new result.data
    for i in v.low..v.high:
      result[i] = v[i]+w[i]
# shorthand to^^
proc `+` *[N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= add(v,w)

proc sub *[N:static[int]] (v, w: Vector[N]): Vector[N] = 
    new result.data
    for i in v.low..v.high:
      result[i] = v[i]+w[i]
# shorthand to^^
proc `-` *[N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= sub(v,w)


proc `*` *[N:static[int]] (a: float64,v: Vector[N]): Vector[N] =
    new result.data
    for i in v.low..v.high:
      result[i] = a*v[i]

proc `.*` *[N:static[int]] (v,w: Vector[N]): Vector[N] =
    new result.data
    for i in v.low..v.high:
      result[i] = v[i]*w[i]


proc `/`* [N:static[int]](v: Vector[N],val:float): Vector[N] =
  assert(val!=0.0, "Div by zero")
  new result.data
  for i in v.low..v.high:
    result.data[i] = v.data[i]/val

proc `./`* [N:static[int]](v,w: Vector[N]): Vector[N] =
  new result.data
  for i in v.low..v.high:
    assert(w[i]!=0.0, "Division by zero")
    result[i] = v[i]/w[i]

when isMainModule: # Dirty testing

  var r : RowVector[3] = rowVec([1.0,2,3])
  var c : ColVector[3] = colVec([1.0,2,3])
  var a : Vector[3] = colVec([1.0,2,3])

  assert( a is ColVector == true )
  assert( r.len+c.len == 6 )
  assert( r[2] == 3.0 )
  
  c[1] = 4.0
  assert( c[1] == 4.0 )

  var rr = r.t
  rr[0] = 5.0
  assert( rr is ColVector == true and r is RowVector == true, "Transposing a row vector gives a col vector. The original row vector is not modified" )
  assert( rr[0] == 5.0 and r[0] == 1.0, "Modifying the transposed vector does not afftect the original")

  assert( norm(r) == 3.0 )
  assert( norm(rr) == 5.0 )

  echo dot(r,r)