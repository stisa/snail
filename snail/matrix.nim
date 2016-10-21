from vector import RowVector,ColVector,Vector
from strutils import formatFloat,FloatFormatMode
type 
    #[
    Matrix with fixed size, Rows*Columns
    eg Matrix [ 2, 3] = | a b c |
                        | e f g |
    ]#
    Matrix* [N, M : static[int]] = object
        data *: ref array[N*M, float]
    
    Array[N: static[int]] = array[N, float64] # hackhis, gives nicer code tho
    BiArray[N,M: static[int]] = array[N, array[M, float64]]


proc low(m: Matrix):int = m.data[].low
  
proc high(m: Matrix):int = m.data[].high

proc `[]`*[N,M : static[int]](m : Matrix[N,M], i, j: int): float {.inline.}= 
  assert(i<N, "Row index out of bounds")
  assert(j<M, "Column index out of bounds")
  m.data[i * N + j]

proc `[]=`*[N,M : static[int]](m : var Matrix[N,M], i, j: int, val: float) {.inline.}=
  assert(i<N, "Row index out of bounds")
  assert(j<M, "Column index out of bounds")
  m.data[i * N + j] = val 

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
  assert(N*M >= K)
  if N*M>K:
    for i in arr.low..arr.high: result.data[][i] = arr[i]
  else:
    result.data[] = arr

# matrix([2-D arr]) = Matrix[N,M]
proc matrix* [N,M:static[int]](arr: BiArray[N,M]): Matrix[N,M] = 
    new result.data
    #for i in arr.low..arr.high: result.data[][i*N..i*N+M] = arr[i]
    for i,r in arr.pairs:
      for j,c in r.pairs: result[i,j] = c
#[ Future ]
  proc randomMatrix* (N: static[int], M: static[int], max: float = 1): Matrix[N,M] =  
    #for i in 0..(N*M)-1: result.data[i] = random(max)
    new result.data
    #for i in 0..(N*M)-1: result.data[i] = random(max)
    for i in mitems(result.data[]): i = random(max)
]#

proc dims*[N,M:static[int]](m: Matrix[N,M]): tuple[rows:int,cols:int] {.inline.}= (N,M)

proc row *[N,M : static[int]](m : Matrix[N,M], r: int) : RowVector[M]=
  ## Return a copy row r from the matrix
  assert(r<N, "The matrix has less rows than the requested row index")
  new result.data
  for i in 0..<M: result.data[i] = m.data[r*m.N+i]

proc overWriteRow *[N,M : static[int]](m :var Matrix[N,M], r: int,rowv:RowVector[M]) =
  ## Overwrite row r in the matrix m
  assert(r<N, "The matrix has less rows than the requested row index")
  for i in 0..M-1: m.data[r*m.N+i] = rowv[i]

proc col *[N,M : static[int]](m : Matrix[N,M], c: int) : ColVector[N]=
  ## Return a copy of col c from the matrix
  assert(c<M, "The matrix has less cols than the requested col index")
  new result.data
  for i in 0..<N: result.data[i] = m.data[i*m.N+c]

when isMainModule:
  from vector import colVec,rowVec,`==`
  var m : Matrix[2,2] = matrix([[0.0,1],[1.0,0]])
  var w : Matrix[2,2] = [0.0,1,1,0].toMatrix(2,2)
  assert(m==w)
  assert(dims(m) == (2,2))
  assert(m.row(1) == rowVec([1.0,0]))
  assert(m.col(1) == colVec([1.0,0]))
  echo m