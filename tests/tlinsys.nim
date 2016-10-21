import ../snail/matrix,../snail/vector # So we can use matrices and vectors
from ../snail/linsys import ppge

var A = matrix([[2.0,0],[0.0,3]])
var b = colVec([1.0,1])

proc `\`[N:static[int]](m:Matrix[N,N],v:Vector[N]):Vector[N] = ppge(m,v) # So we can match matlab syntax

let x = A\b
echo x