

type 
    #[
    Matrix with fixed size, Rows*Columns
    eg Matrix [ 2, 3] = | a b c |
                        | e f g |
    ]#
    Matrix [N, M : static[int]] = object
        data : array [N*M, float64]
    #[
    Vector with fixed size, defaults to row vector 
    eg Vector [3] = | a b c |
    ]#
    Vector [N:static[int]] = object
        data: array [N, float64]
        isCol: bool
    Array[N: static[int]] = array[N, float64] # hackhis, gives nicer code tho

proc vector [N:static[int]] (arr: Array[N], isCol:bool = false): Vector[N] = 
    result.data = arr
    result.isCol = isCol

# transpose in place. Should file a bug with nim: single ' not allowed as operator
proc `^` [N:static[int]] (v: var Vector[N]): Vector[N] =
    if v.isCol: v.isCol=false else: v.isCol=true
    return v 

proc matrix [N:static[int],M:static[int]] (arr: Array[N], isCol:bool = false): Vector[N] = 
    result.data = arr
    result.isCol = isCol

var v :Vector[3] = Vector[3](data: [2.0,2.0,2.0], isCol:false) 

var vv : Vector[3] = vector([2.0,2.0,1.0],true)
echo vv
echo ^v
