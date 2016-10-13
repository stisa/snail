
import times,nalg #,linalg

var startTime,endTime: float

proc gauss*[N:static[int]](A:var Matrix[N,N],b:Vector[N]):Vector[N] =
    var m : float
    result = b
    for i in 0..N-1:
        let ii :float = A[i,i]
        echo ii
        for j in i..N-1:
            m = A[j,i] / ii
            for k in i..N-1: A[j,k] = A[j,k] - m*A[i,k]
            result[j]=result[j]-m*result[i]
    #bss
    result[N-1] = result[N-1]/A[N-1,N-1] 
    for i in N-2..0:
        for j in i+1..N-1:
            result[i] = result[i] - A[i,j] * result[j]
        result[i] = result[i]/A[i,i]

var f2 :Matrix[2,2] = matrix2D([[1.0,0],[0.0,1.0]])
var v2:Vector[2] = colVector(2,[3.0,3])
echo gauss(f2,v2)
