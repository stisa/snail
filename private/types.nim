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
        isCol: bool
    
    Vec* [N:static[int]] = object
        data: array [N, float64]

    Array[N: static[int]] = array[N, float64] # hackhis, gives nicer code tho

proc vector* [N:static[int]] (arr: Array[N], isCol:bool = false): Vector[N] = 
    result.data = arr
    result.isCol = isCol

proc matrix* [N:static[int],M:static[int]] (arr: Array[N]): Matrix[N,M] = 
    result.data = arr

## These should probably go to their own file

proc len*[N: static[int]](v: Vector[N]): int = N

proc at[ N,M : static[int] ](m : Matrix[N,M], i, j: int): float64 = m.data[i * m.N + j] 

proc `[]`*[ N,M : static[int] ](m : Matrix[N,M], i, j: int): float64 = m.data[i * m.N + j]

proc `[]=`*[ N,M : static[int] ](m : var Matrix[N,M], i, j: int, val: float64)= m.data[i * m.N + j] = val 

#extract a row
proc row *[ N,M : static[int] ](m : var Matrix[N,M], r: int) : Matrix[1,M]=
    assert(r<N, "The matrix has less rows than the requested row index") 
    var ind:int = 0
    for i in 0..M-1:
        result[0,ind] = m.data[r*m.N+i]
        ind+=1

#extract s vol
proc col *[ N,M : static[int] ](m : var Matrix[N,M], c: int) : Matrix[N,1]=
    assert(c<M, "The matrix has less cols than the requested col index") 
    var ind:int = c
    for i in 0..N-1:  # uglyy
        echo result[0,1]  
        #result[i,0] = m.data[ind]
        #ind+=M-1
