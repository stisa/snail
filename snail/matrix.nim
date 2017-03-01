from vector import RowVector,ColVector,Vector,dot,`[]=`,`$`
from strutils import formatFloat,FloatFormatMode

when defined openblas:
  import nimblas

const maxstack :int = 100

type 
    #[
    Matrix with fixed size, Rows*Columns
    eg Matrix [ 2, 3] = | a b c |
                        | e f g |
    ]#
    Matrix* [N, M : static[int]] = object
       # when N>maxstack:
        data *: ref array[N*M, float]
       # else: data*: array[N*M,float]
        when not defined(js):p*: ptr float
    Array[N: static[int]] = array[N, float64] # hackhis, gives nicer code tho
    BiArray[N,M: static[int]] = array[N, array[M, float64]]


proc low(m: Matrix):int = m.data[].low
  
proc high(m: Matrix):int = m.data[].high

proc `[]`*[N,M : static[int]](m : Matrix[N,M], i, j: int): float {.inline.}= 
  assert(i<N, "Row index out of bounds")
  assert(j<M, "Column index out of bounds")
  m.data[i * M + j]

proc `[]=`*[N,M : static[int]](m : var Matrix[N,M], i, j: int, val: float) {.inline.}=
  assert(i<N, "Row index out of bounds")
  assert(j<M, "Column index out of bounds")
  m.data[i * M + j] = val 

proc `==`*[N,M : static[int]](m,w: Matrix[N,M]):bool =
  for i,e in pairs(m.data[]):
    if e != w.data[][i]: return false
  result = true
        
proc `$`*[N,M:static[int]] (m: Matrix[N,M]): string =
  result = "["
  if isNil(m.data): result.add("nil]\n")
  else:
    for i in 0..<N:
      for j in 0..<M:
        let fstring = if m[i,j]>=0: '+'&formatFloat(m[i,j],ffDecimal,2) 
                      else: formatFloat(m[i,j],ffDecimal,2)
        if(j==M-1) and (i!=N-1): result.add(fstring&"|\n|")
        elif(j==M-1) and (i==N-1): result.add(fstring&"]\n")
        else:
          result.add(fstring & ", ")

proc toMatrix* [K](arr: Array[K],N,M:static[int]): Matrix[N,M] =
  ## Shape the arr array into a matrix with N rows and M columns.
  ##
  ## If the length of the array is less than N*M, the array elements
  ## will be copied in the matrix, leaving excess matrix element to 0.0
  ##
  ## The array needs to have N*M or less elements
  new result.data
  when not defined(js): result.p = addr result.data[0]
  assert(N*M >= K)
  if N*M>K:
    for i in arr.low..arr.high: result.data[][i] = arr[i]
  else:
    result.data[] = arr

# matrix([2-D arr]) = Matrix[N,M]
proc matrix* [N,M:static[int]](arr: BiArray[N,M]): Matrix[N,M] = 
    #when N>maxstack:
    new result.data
    when not defined(js): result.p = addr result.data[0]
    for i,r in arr.pairs:
      for j,c in r.pairs: result[i,j] = c
#[ Future ]
  proc randomMatrix* (N: static[int], M: static[int], max: float = 1): Matrix[N,M] =  
    #for i in 0..(N*M)-1: result.data[i] = random(max)
    new result.data
    result.p = addr result.data[0]
    #for i in 0..(N*M)-1: result.data[i] = random(max)
    for i in mitems(result.data[]): i = random(max)
]#

proc identity*(N:static[int]):Matrix[N,N]=
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i in 0..<N: result[i,i] = 1

proc dims*[N,M:static[int]](m: Matrix[N,M]): tuple[rows:int,cols:int] {.inline.}= (N,M)

proc row *[N,M : static[int]](m : Matrix[N,M], r: int) : RowVector[M]=
  ## Return a copy row r from the matrix
  assert(r<N, "The matrix has less rows than the requested row index")
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i in 0..<M: result.data[i] = m.data[r*m.M+i]

proc overWriteRow *[N,M : static[int]](m :var Matrix[N,M], r: int,rowv:RowVector[M]) =
  ## Overwrite row r in the matrix m
  assert(r<N, "The matrix has less rows than the requested row index")
  for i in 0..M-1: m.data[r*m.N+i] = rowv[i]

proc col *[N,M : static[int]](m : Matrix[N,M], c: int) : ColVector[N]=
  ## Return a copy of col c from the matrix
  assert(c<M, "The matrix has less cols than the requested col index")
  new result.data
  when not defined(js):result.p = addr result.data[0]
  
  for i in 0..<N: result.data[i] = m.data[i*m.M+c]

proc `t`* [N,M:static[int]](m: Matrix[N,M]): Matrix[M,N] =
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i in m.low..m.high: result.data[][i] = m.data[][i]

proc reshape* [N,M:static[int]](m: Matrix[N,M],U,V:static[int]): Matrix[U,V] =
  assert(N*M==U*V, "Matrix and its reshaping have different number of elements")
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i in m.low..m.high: result.data[][i] = m.data[][i]

proc matMul* [N,M,V:static[int]](m: Matrix[N,M], w: Matrix[M,V]) :Matrix[N,V] =
  new result.data
  when not defined(js):result.p = addr result.data[0]
  ## Naive matrix multiplication
  when declared(nimblas):
    #nimblas.copy(m.p, FIXME: deepcopy m into result
    nimblas.gemm(rowMajor,noTranspose,noTranspose,N,V,M,1.0,m.p,M,w.p,V,0,result.p,V)
  else:
    for r in 0..<N: # iter on rows of m
      for c in 0..<V: # on cols of w
        result[r,c] = dot(m.row(r),w.col(c))

template `*`* [N,M,V:static[int]](m: Matrix[N,M],
  w: Matrix[M,V]) :Matrix[N,V] = matMul(m,w)

proc vecMatMul* [N,M:static[int]](m: Matrix[N,M], v: ColVector[M]) :ColVector[N] =
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for r in 0..<N: # iter on rows of m
    result[r] = dot(m.row(r),v) 

proc vecMatMul* [N,M:static[int]](v: RowVector[N],m: Matrix[N,M]) :RowVector[M] =
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for c in 0..<M: # iter on rows of m
    result[c] = dot(v,m.col(c)) 
#FIXME error around here
template `*`* [N,M:static[int]](m: Matrix[N,M], v: ColVector[M]) :ColVector[N] = vecMatMul(m,v)

template `*`* [N,M:static[int]](v: RowVector[N],m: Matrix[N,M]) :RowVector[M] = vecMatMul(v,m)


proc matAdd *[N,M:static[int]] (m,w: Matrix[N,M]): Matrix[N,M] = 
    new result.data
    when not defined(js):result.p = addr result.data[0]
    for i,e in m.data[].pairs:
      result.data[i] = e+w.data[i]
# shorthand to^^
proc `+` *[N,M:static[int]] (m: Matrix[N,M], w: Matrix[N,M]): Matrix[N,M]{.inline.}= matAdd(m,w)

proc matSub *[N,M:static[int]] (m,w: Matrix[N,M]): Matrix[N,M] = 
    new result.data
    when not defined(js):result.p = addr result.data[0]
    for i,e in m.data[].pairs:
      result.data[i] = e-w.data[i]
# shorthand to^^
proc `-` *[N,M:static[int]] (m: Matrix[N,M], w: Matrix[N,M]): Matrix[N,M]{.inline.}= matSub(m,w)

proc elMatMul *[N,M:static[int]] (val:float,m: Matrix[N,M]): Matrix[N,M] = 
    new result.data
    when not defined(js):result.p = addr result.data[0]
    if val == 0.0: return # short circuit, the result is already 0 so no need to do it again
    for i,e in m.data[].pairs:
      result.data[i] = val*e
# shorthand to^^
proc `.*` *[N,M:static[int]] (val:float,m: Matrix[N,M]): Matrix[N,M]{.inline.}= elMatMul(val,m)

proc elMatDiv *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M] = 
    assert(val!=0.0, "Division by zero")
    new result.data
    when not defined(js):result.p = addr result.data[0]
    for i,e in m.data[].pairs:
      result.data[i] = e/val
# shorthand to^^
proc `./` *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M]{.inline.}= elMatDiv(m,val)

proc elMatAdd *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M] = 
    new result.data
    when not defined(js):result.p = addr result.data[0]
    for i,e in m.data[].pairs:
      result.data[i] = e+val
# shorthand to^^
proc `.+` *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M]{.inline.}= elMatAdd(m,val)

proc elMatSub *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M] = 
    new result.data
    when not defined(js):result.p = addr result.data[0]
    for i,e in m.data[].pairs:
      result.data[i] = e-val
# shorthand to^^
proc `.-` *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M]{.inline.}= elMatSub(m,val)

proc subtractVecFromRow* [N,M:static[int]](A:var Matrix[N,M],row:int,vec:RowVector[M],times:float=1.0)=
  assert(row<N)
  for j in 0..<M: A[row,j] = A[row,j]-A[row,j]*times*vec[j]

proc subtractVecFromCol* [N,M:static[int]](A:var Matrix[N,M],col:int,vec:ColVector[N],times:float=1.0)=
  assert(col<M)
  for j in 0..<N: A[j,col] = A[j,col]-A[j,col]*times*vec[j]

proc divRowBy* [N,M:static[int]](A:var Matrix[N,M],row:int,val:float)=
  assert(row<N)
  for j in 0..<M: A[row,j] = A[row,j]/val

proc divColBy* [N,M:static[int]](A:var Matrix[N,M],col:int,val:float)=
  for j in 0..<N: A[j,col] = A[j,col]/val

proc norm*[N,M:static[int]] (m: Matrix[N,M]): float =
  for i in 0..<N:
    var tmp = 0.0
    for j in 0..<M:
      tmp += abs(m[i,j])
    echo tmp
    if tmp>result: result = tmp

when isMainModule:
  from vector import colVec,rowVec,`==`
  var m : Matrix[2,2] = matrix([[0.0,1],[1.0,0]])
  var w : Matrix[2,2] = [0.0,1,1,0].toMatrix(2,2)
  var r : Matrix[2,2] = [1.0,0,0,1].toMatrix(2,2)
  var cv: ColVector[2] = colVec([1.0,1])
  var rv: RowVector[2] = rowVec([1.0,1.0])
  assert(m==w)
  assert(dims(m) == (2,2))
  assert(m.row(1) == rowVec([1.0,0]))
  assert(m.col(1) == colVec([1.0,0]))
  
  assert(m*cv==cv)
  assert(rv*m==rv)

  assert(m*w==r)
  
  #echo m*v
  echo(currentSourcePath & " passed")
