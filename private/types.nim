type 
    #[
    Matrix with fixed size, Rows*Columns
    eg Matrix [ 2, 3] = | a b c |
                        | e f g |
    ]#
    Matrix* [N, M : static[int]] = object
        data : array [N*M, float64]
    #[
    Vector with fixed size, defaults to row vector 
    eg Vector [3] = | a b c |
    ]#
    Vector* [N:static[int]] = object
        data: array [N, float64]
        isCol*: bool

    Array[N: static[int]] = array[N, float64] # hackhis, gives nicer code tho
    BiArray[N,M: static[int]] = array[N, array[M, float64]]

#[ Vector methods ]#
# vector( [1-D arr], bool ) = Vector[N]
proc vector* [N:static[int]] (arr: Array[N], isCol:bool = false): Vector[N] = 
    result.data = arr
    result.isCol = isCol

proc len*[N: static[int]](v: Vector[N]): int = N

proc `[]`*(v: Vector, i:int): float64 = v.data[i]

proc `[]=`*[N : static[int]](v: Vector[N], i:int, val: float64)= v.data[i] = val 

#[ Matrix methods ]#

# matrix(m, [1-D arr]) = Matrix[N,M]
proc matrix* [N,M:static[int]](m: Matrix[N,M],arr: Array[N*M]): Matrix[N,M] = 
    result.data = arr

# matrix([2-D arr]) = Matrix[N,M]
proc matrix* [N,M:static[int]](arr: BiArray[N,M]): Matrix[N,M] = 
    for i in 0..N-1:
        result.data[i*N..i*N+M-1] = arr[i]

proc len*[N:static[int],M:static[int]](m: Matrix[N,M]): int = N*M

proc dims*[N,M:static[int]](m: Matrix[N,M]): tuple[rows:int,cols:int] = (N,M)

proc `[]`*[N,M : static[int]](m : Matrix[N,M], i, j: int): float64 = m.data[i * m.N + j]

proc `[]=`*[N,M : static[int]](m : var Matrix[N,M], i, j: int, val: float64)= m.data[i * m.N + j] = val 

#extract a row
proc row *[N,M : static[int]](m : var Matrix[N,M], r: int) : Vector[M]=
    assert(r<N, "The matrix has less rows than the requested row index")
    for i in 0..M-1:
        result.data[i] = m.data[r*m.N+i]
        
#extract a col
proc col *[N,M : static[int]](m : var Matrix[N,M], c: int) : Vector[N]=
    assert(c<M, "The matrix has less cols than the requested col index")
    result.isCol = true
    for i in 0..N-1:
        result.data[i] = m.data[i*m.N+c]
       