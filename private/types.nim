type 
    #[
    Matrix with fixed size, Rows*Columns
    eg Matrix [ 2, 3] = | a b c |
                        | e f g |
    ]#
    Matrix* [N, M : static[int]] = object
        data *: ref array [N*M, float]
    #[
    Vector with fixed size, defaults to row vector 
    eg Vector [3] = | a b c |
    ]#
    Vector* [N:static[int]] = object
        data*:ref array [N, float]
        isCol*: bool
    VecType {.pure.}= enum
        Col, Row 


    Array*[N: static[int]] = array[N, float64] # hackhis, gives nicer code tho
    MArray*[N,M: static[int]] = array[N*M, float64] # hackhis, gives nicer code tho
    BiArray*[N,M: static[int]] = array[N, array[M, float64]]

#[ Vector methods ]#
# vector( [1-D arr], bool ) = Vector[N]
proc vector*  (N:static[int],arr: Array[N], isCol:bool = false): Vector[N] =
    new result.data
    result.data[] = arr
    result.isCol = isCol

proc colVector*  (N:static[int],arr: Array[N]): Vector[N] =
    new result.data
    result.data[] = arr
    result.isCol = true

proc rowVector*  (N:static[int],arr: Array[N]): Vector[N] =
    new result.data
    result.data[] = arr

proc randomVec* (N: static[int],max: float = 1): Vector[N] =  
    new result.data
    for i in mitems(result.data[]): i = random(max)

proc len*[N: static[int]](v: Vector[N]): int = N

proc `[]`*[N : static[int]](v: Vector[N], i:int): float {.inline.} = v.data[i]

proc `[]=`*[N : static[int]](v: Vector[N], i:int, val: float){.inline.} = v.data[i] = val 

#[ Matrix methods ]#

# matrix(m, [1-D arr]) = Matrix[N,M]
#proc matrix* [N,M:static[int]](m: Matrix[N,M],arr: Array[N*M]): Matrix[N,M] = 
#    new result.data
#    result.data = arr

proc matrix* (N,M:static[int],arr: Array[N*M]): Matrix[N,M] = 
    new result.data
    result.data[] = arr

# matrix([2-D arr]) = Matrix[N,M]
proc matrix2D* [N,M:static[int]](arr: BiArray[N,M]): Matrix[N,M] = 
    new result.data
    for i in 0..N-1: result.data[][i*N..i*N+M-1] = arr[i]

#proc randomMatrix1* (N: static[int], M: static[int], max: float = 1): Matrix[N,M] =  
    #result.data.apply(proc(x:float):float = random(max))
#    for i in mitems(result.data): i = random(max) 

proc randomMatrix* (N: static[int], M: static[int], max: float = 1): Matrix[N,M] =  
    #for i in 0..(N*M)-1: result.data[i] = random(max)
    new result.data
    #for i in 0..(N*M)-1: result.data[i] = random(max)
    for i in mitems(result.data[]): i = random(max)

proc len*[N:static[int],M:static[int]](m: Matrix[N,M]): int {.inline.} = N*M

proc dims*[N,M:static[int]](m: Matrix[N,M]): tuple[rows:int,cols:int] {.inline.}= (N,M)

proc `[]`*[N,M : static[int]](m : Matrix[N,M], i, j: int): float {.inline.}= m.data[i * M + j]

proc `[]=`*[N,M : static[int]](m : var Matrix[N,M], i, j: int, val: float) {.inline.}= m.data[i * M + j] = val 

#extract a row
proc row *[N,M : static[int]](m : Matrix[N,M], r: int) : Vector[M]=
    assert(r<N, "The matrix has less rows than the requested row index")
    new result.data
    for i in 0..M-1: result.data[i] = m.data[r*m.M+i]

proc overWriteRow *[N,M : static[int]](m :var Matrix[N,M], r: int,rowv:Vector[M]) =
    assert(r<N, "The matrix has less rows than the requested row index")
    for i in 0..M-1: m.data[r*m.M+i] = rowv[i]

#extract a col
proc col *[N,M : static[int]](m : Matrix[N,M], c: int) : Vector[N]=
    assert(c<M, "The matrix has less cols than the requested col index")
    new result.data
    result.isCol = true
    for i in 0..N-1: result.data[i] = m.data[i*m.M+c]
