from vector import RowVector,ColVector,Vector,dot,`[]=`,`$`
from strutils import formatFloat,FloatFormatMode

when defined openblas:
  import nimblas

const Epsilon :float = 1.0e-6 #TODO: implement {.floatdefine.}

type 
    #[
    Matrix with fixed size, Rows*Columns
    eg: Matrix [2, 3] = | a b c |
                        | e f g |
    ]#
    Matrix* [N, M: static[int]] = object
        data*: ref array[N*M, float]
        when not defined(js): p*: ptr float
    Array[N: static[int]] = array[N, float] # hackhis, gives nicer code tho
    BiArray[N,M: static[int]] = array[N, array[M, float]]

proc low(m: Matrix): int = m.data[].low
  
proc high(m: Matrix): int = m.data[].high

proc `[]`*[N,M: static[int]](m: Matrix[N,M], i, j: int): float {.inline.}= 
  assert(i<N, "Row index out of bounds")
  assert(j<M, "Column index out of bounds")
  m.data[i * M + j]

proc `[]=`*[N,M: static[int]](m: var Matrix[N, M], i, j: int, val: float) {.inline.}=
  assert(i<N, "Row index out of bounds")
  assert(j<M, "Column index out of bounds")
  m.data[i * M + j] = val 

proc eq*[N,M: static[int]](m,w: Matrix[N,M], epsilon: float = Epsilon): bool =
  ## Equality up to epsilon precision.
  let wdata = w.data[]
  for i,e in pairs(m.data[]):
    if abs(e - wdata[i])>epsilon: return false
  result = true

proc `==`*[N,M: static[int]](m,w: Matrix[N,M], epsilon: float = Epsilon): bool {.inline} =
  ## ALias for `eq`
  eq(m,w,epsilon)

proc `===`*[N,M: static[int]](m,w: Matrix[N,M]): bool =
  ## Exact equality. Beware floating point errors.
  let wdata = w.data[]
  for i,e in pairs(m.data[]):
    if e != wdata[i]: return false
  result = true

proc `$`*[N,M: static[int]] (m: Matrix[N,M]): string =
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

proc toMatrix* [K:static[int]](arr: Array[K], N, M: static[int]): Matrix[N,M] =
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
proc matrix* [N,M: static[int]](arr: BiArray[N,M]): Matrix[N,M] = 
    ## Create a matrix from a 2-D array of floats.
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

proc identity*(N: static[int]): Matrix[N,N]=
  ## Return the identity matrix with dimension NxN
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i in 0..<N: result[i,i] = 1

proc dims*[N,M:static[int]](m: Matrix[N,M]): tuple[rows:int,cols:int] {.inline.}= (N,M)
  ## Return the dimension of a matrix as a tuple of ints (rows,cols)

proc row *[N,M : static[int]](m : Matrix[N,M], r: int) : RowVector[M]=
  ## Return a copy of row `r` from the matrix as a rowvector
  assert(r<N, "The matrix has less rows than the requested row index")
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i in 0..<M: result.data[i] = m.data[r*m.M+i]

proc overWriteRow *[N,M : static[int]](m :var Matrix[N,M], r: int,rowv:RowVector[M]) =
  ## Overwrite row r in the matrix m ( r needs to be a row vector )
  assert(r<N, "The matrix has less rows than the requested row index")
  for i in 0..M-1: m.data[r*m.N+i] = rowv[i]

proc col *[N,M : static[int]](m : Matrix[N,M], c: int) : ColVector[N]=
  ## Return a copy of col c from the matrix as a colvector
  assert(c<M, "The matrix has less cols than the requested col index")
  new result.data
  when not defined(js):result.p = addr result.data[0]
  
  for i in 0..<N: result.data[i] = m.data[i*m.M+c]

proc `t`* [N,M:static[int]](m: Matrix[N,M]): Matrix[M,N] =
  ## Transpose the matrix.
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i in m.low..m.high: result.data[][i] = m.data[][i]

proc reshape* [N,M:static[int]](m: Matrix[N,M],U,V:static[int]): Matrix[U,V] =
  ## Return a new matrix with dims (U,V) from a matrix with dims (N,M)
  assert(N*M==U*V, "Matrix and its reshaping have different number of elements")
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i in m.low..m.high: result.data[][i] = m.data[][i]

proc matMul* [N,M,V:static[int]](m: Matrix[N,M], w: Matrix[M,V]) :Matrix[N,V] =
  ## Matrix-Matrix multiplication. Can use openblas.
  ## The nim implementation is a naive double loop, for now.
  new result.data
  when not defined(js):result.p = addr result.data[0]
  when declared(nimblas):
    #nimblas.copy(m.p, FIXME: deepcopy m into result
    nimblas.gemm(rowMajor,noTranspose,noTranspose,N,V,M,1.0,m.p,M,w.p,V,0,result.p,V)
  else:
    for r in 0..<N: # iter on rows of m
      for c in 0..<V: # on cols of w
        result[r,c] = dot(m.row(r),w.col(c))

proc `*`* [N,M,V:static[int]](m: Matrix[N,M], w: Matrix[M,V]) :Matrix[N,V] {.inline.} = matMul(m,w)

  ## Shorthand for matmul
proc vecMatMul* [N,M:static[int]](m: Matrix[N,M], v: ColVector[M]) :ColVector[N] =
  ## Matrix-vector multiplication.
  ## The vector needs to be a column vector.
  ## Return a column vector.
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for r in 0..<N: # iter on rows of m
    result[r] = dot(m.row(r),v) 

proc vecMatMul* [N,M:static[int]](v: RowVector[N],m: Matrix[N,M]) :RowVector[M] =
  ## vector-matrix multiplication.
  ## Vector needs to be a row vector.
  ## Return a row vector.
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for c in 0..<M: # iter on rows of m
    result[c] = dot(v,m.col(c)) 

proc `*`* [N,M:static[int]](m: Matrix[N,M], v: ColVector[M]) :ColVector[N] {.inline.} = vecMatMul(m,v)
  ## Shorthand for vecmatmul

proc `*`* [N,M:static[int]](v: RowVector[N],m: Matrix[N,M]) :RowVector[M] {.inline.} = vecMatMul(v,m)
  ## Shorthand for vecmatmul

proc matAdd *[N,M:static[int]] (m,w: Matrix[N,M]): Matrix[N,M] = 
  ## Add two matrices with same dimensions. 
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i,e in m.data[].pairs:
    result.data[i] = e+w.data[i]
proc `+` *[N,M:static[int]] (m: Matrix[N,M], w: Matrix[N,M]): Matrix[N,M]{.inline.}= matAdd(m,w)
  ## Shorthand for matadd

proc matSub *[N,M:static[int]] (m,w: Matrix[N,M]): Matrix[N,M] = 
  ## Subtract two matrices with same dimensions. 
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i,e in m.data[].pairs:
    result.data[i] = e-w.data[i]
proc `-` *[N,M:static[int]] (m: Matrix[N,M], w: Matrix[N,M]): Matrix[N,M]{.inline.}= matSub(m,w)
  ## shorthand to matsub

proc elMatMul *[N,M:static[int]] (val:float,m: Matrix[N,M]): Matrix[N,M] = 
  ## Multiply every element in matrix by a float.
  new result.data
  when not defined(js):result.p = addr result.data[0]
  if val == 0.0: return # short circuit, the result is already 0 so no need to do it again
  for i,e in m.data[].pairs:
    result.data[i] = val*e

proc `.*` *[N,M:static[int]] (val:float,m: Matrix[N,M]): Matrix[N,M]{.inline.}= elMatMul(val,m)
  ## shorthand to elMatMul
proc elMatDiv *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M] = 
  ## Divide every element in matrix by a float.
  assert(val!=0.0, "Division by zero")
  new result.data
  when not defined(js):result.p = addr result.data[0]
  for i,e in m.data[].pairs:
    result.data[i] = e/val
proc `./` *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M]{.inline.}= elMatDiv(m,val)
  ## shorthand to elMatDiv

proc elMatAdd *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M] = 
    new result.data
    when not defined(js):result.p = addr result.data[0]
    for i,e in m.data[].pairs:
      result.data[i] = e+val

proc `.+` *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M]{.inline.}= elMatAdd(m,val)
  ## shorthand to elMatAdd
proc elMatSub *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M] = 
    new result.data
    when not defined(js):result.p = addr result.data[0]
    for i,e in m.data[].pairs:
      result.data[i] = e-val
proc `.-` *[N,M:static[int]] (m: Matrix[N,M],val:float): Matrix[N,M]{.inline.}= elMatSub(m,val)
  ## shorthand to elMatSub

proc subtractVecFromRow* [N,M:static[int]](A:var Matrix[N,M],row:int,vec:RowVector[M],times:float=1.0)=
  ## Subtract in place a vector from a matrix row, can also specify how many times to subtract.
  assert(row<N)
  for j in 0..<M: A[row,j] = A[row,j]-A[row,j]*times*vec[j]

proc subtractVecFromCol* [N,M:static[int]](A:var Matrix[N,M],col:int,vec:ColVector[N],times:float=1.0)=
  ## Same as subtractVecFromRow, but for cols.
  assert(col<M)
  for j in 0..<N: A[j,col] = A[j,col]-A[j,col]*times*vec[j]

proc divRowBy* [N,M:static[int]](A:var Matrix[N,M],row:int,val:float)=
  ## Divide a row in a matrix by a float. Modifies the matrix in place
  assert(row<N)
  for j in 0..<M: A[row,j] = A[row,j]/val

proc divColBy* [N,M:static[int]](A:var Matrix[N,M],col:int,val:float)=
  ## Divide a col in a matrix by a float. Modifies the matrix in place
  for j in 0..<N: A[j,col] = A[j,col]/val

proc norm*[N,M:static[int]] (m: Matrix[N,M]): float =
  for i in 0..<N:
    var tmp = 0.0
    for j in 0..<M:
      tmp += abs(m[i,j])
    echo tmp
    if tmp>result: result = tmp

iterator rows*[N,M:static[int]](m:Matrix[N,M]): RowVector[M] {.inline.} =
  ## iterates over rows. Each row is a copy
  var i = 0
  while i<N:
    yield m.row(i)
    inc(i)

iterator cols*[N,M:static[int]](m:Matrix[N,M]): ColVector[M] {.inline.} =
  ## Iterate over columns. The column is a copy.
  var i = 0
  while i<M:
    yield m.col(i)
    inc(i)

proc row*[N,M : static[int]](m :var Matrix[N,M], r: int,rowv:RowVector[M]|array[M,float]|seq[float]) =
  ## Overwrite row r in the matrix m ( r needs to be a row vector,array or seq )
  for i in 0..<M: m.data[r*m.N+i] = rowv[i]

proc col*[N,M : static[int]](m :var Matrix[N,M], c: int,colv:ColVector[N]|array[N,float]|seq[float]) =
  ## Overwrite col c in the matrix m ( c needs to be a col vector, array or seq )
  for i in 0..<N: m.data[i*m.N+c] = colv[i]

