import ../snail/matrix,../snail/vector # So we can use matrices and vectors
from ../snail/linsys import ppge

var A = matrix([[2.0,0],[0.0,3]])
var b = colVec([1.0,1])

proc `\`[N:static[int]](m:Matrix[N,N],v:Vector[N]):Vector[N] = ppge(m,v) # So we can match matlab syntax

let x = A\b
echo x

A = matrix([[0.0,5,6],[4.0,5,7],[9.0,2,3]])
b = colVector([11.0,16,15])
#var x = colVector(3,[])
#assert($solve(A,b)==
assert( $(A\b) == "[+1.15|\n|+1.73|\n|+0.39]\n" )